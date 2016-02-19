class Stop < ApplicationRecord
  validates_presence_of :stop_lat, :stop_lon, :stop_id, :stop_description, :stop_name, :location_type, :stop_code
end
