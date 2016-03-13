class Stop < ApplicationRecord
  validates_presence_of :stop_lat, :stop_lon, :stop_id, :stop_name, :location_type, :stop_code
  has_many :stop_times, primary_key: :stop_id
  has_many :trips, through: :stop_times
  has_many :routes, through: :trips
  serialize :route_colors, Array

  def set_route_colors
    route_colors = routes.pluck(:route_short_name).uniq.sort
    update(route_colors: route_colors)
  end
end
