require 'csv'

class Import

  def self.run
    ActiveRecord::Base.logger.level = 1

    calendars.each do |calendar|
      Calendar.where(
        service_id:   calendar["service_id"],
        monday:       to_bool(calendar["monday"]),
        tuesday:      to_bool(calendar["tuesday"]),
        wednesday:    to_bool(calendar["wednesday"]),
        thursday:     to_bool(calendar["thursday"]),
        friday:       to_bool(calendar["friday"]),
        saturday:     to_bool(calendar["saturday"]),
        sunday:       to_bool(calendar["sunday"]),
        start_date:   Date.parse(calendar["start_date"]),
        end_date:   Date.parse(calendar["end_date"])
      ).first_or_create!
    end

    routes.each do |route|
      Route.where(
        route_id:         route["route_id"],
        route_short_name: route["route_short_name"],
        route_long_name:  route["route_long_name"]
      ).first_or_create!
    end

    trips(Route.pluck(:route_id)).each do |trip|
      Trip.where(
        block_id:       trip["block_id"],
        route_id:       trip["route_id"],
        direction_id:   trip["direction_id"],
        trip_headsign:  trip["trip_headsign"],
        shape_id:       trip["shape_id"],
        service_id:     trip["service_id"],
        trip_id:        trip["trip_id"]
      ).first_or_create!
    end

    # this one is over a mil lines long, imports 40kish records, will take a bit
    stop_times(Trip.pluck(:trip_id)).each do |stop_time|
      StopTime.where(
        trip_id:          stop_time["trip_id"],
        arrival_time:     stop_time["arrival_time"],
        departure_time:   stop_time["departure_time"],
        stop_id:          stop_time["stop_id"],
        stop_sequence:    stop_time["stop_sequence"].to_i,
      ).first_or_create!
    end

    stops(StopTime.pluck(:stop_id).uniq).each do |stop|
      Stop.where(
        stop_lat:       stop["stop_lat"].to_f,
        stop_lon:       stop["stop_lon"].to_f,
        stop_id:        stop["stop_id"],
        stop_desc:      stop["stop_desc"],
        stop_name:      stop["stop_name"],
        location_type:  stop["location_type"],
        stop_code:      stop["stop_code"]
      ).first_or_create!
    end


    Stop.all.each(&:set_route_colors)

    # final fix
    Stop.where(stop_name: "U CITY BIG BEND METROLINK  STATION").update(
      stop_name: "U CITY BIG BEND METROLINK STATION"
    )

    StopTime.calculate_seconds_since_midnight
    ActiveRecord::Base.logger.level = 0
  end

  def self.routes
    result = []
    CSV.foreach(csv_path("routes"), headers: true) do |row|
      result << row.to_hash if row["route_type"] == "2"
    end
    result
  end

  def self.trips(route_ids)
    result = []
    CSV.foreach(csv_path("trips"), headers: true) do |row|
      result << row.to_hash if route_ids.include?(row["route_id"])
    end
    result
  end

  def self.stop_times(trip_ids)
    result = []
    CSV.foreach(csv_path("stop_times"), headers: true) do |row|
      result << row.to_hash if trip_ids.include?(row["trip_id"])
    end
    result
  end

  def self.stops(ids)
    result = []
    CSV.foreach(csv_path("stops"), headers: true) do |row|
      result << row.to_hash if ids.include?(row["stop_id"])
    end
    result
  end

  def self.calendars
    result = []
    CSV.foreach(csv_path("calendar"), headers: true) do |row|
      result << row.to_hash
    end
    result
  end

  def self.csv_path(name)
    [Rails.root, "/transit_data/2-18-16/", name, ".txt"].join
  end

  def self.to_bool(str)
    return true if str == "1"
    return false if str == "0"
  end
end
