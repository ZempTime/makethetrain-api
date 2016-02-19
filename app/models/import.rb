require 'csv'

class Import

  def import_metrolink_data
    routes
  end

  def self.routes
    result = []
    CSV.foreach(csv_path("routes"), headers: true) do |row|
      result << row.to_hash if row["route_type"] == "2"
    end
    result
  end

  def self.trips
    result = []
    CSV.foreach(csv_path("trips"), headers: true) do |row|
      result << row.to_hash
    end
    result
  end

  def self.stop_times
    result = []
    CSV.foreach(csv_path("trips"), headers: true) do |row|
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
