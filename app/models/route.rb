class Route < ApplicationRecord
  validates_presence_of :route_id, :route_short_name, :route_long_name
  has_many :trips, primary_key: :route_id
  has_many :stop_times, through: :trips
  has_many :stops, through: :stop_times
end
