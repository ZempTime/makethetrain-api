require 'csv'

class Import

  def self.populate_metrolink_data
    routes.each do |route|
      Route.where(
        route_id:         route["route_id"],
        route_short_name: route["route_short_name"],
        route_long_name:  route["route_long_name"]
      ).first_or_create
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
      ).first_or_create
    end

    stop_times
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

  def self.stop_times
    result = []
    CSV.foreach(csv_path("stop_times"), headers: true) do |row|
      result << row.to_hash
    end
    result
  end

  def self.stops
    result = []
    CSV.foreach(csv_path("stops"), headers: true) do |row|
      result << row.to_hash
    end
    result
  end


  def self.csv_path(name)
    [Rails.root, "/transit_data/2-18-16/", name, ".txt"].join
  end
end
