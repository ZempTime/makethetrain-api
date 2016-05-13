class Stop < ApplicationRecord
  validates_presence_of :stop_lat, :stop_lon, :stop_id, :stop_name, :location_type, :stop_code
  has_many :stop_times, primary_key: :stop_id
  has_many :trips, through: :stop_times
  has_many :routes, through: :trips
  serialize :route_colors, Array

  def self.options_for_select
    all.order(stop_name: :asc).map { |stop| [stop.stop_name, stop.stop_id]}
  end

  def set_route_colors
    route_colors = routes.pluck(:route_short_name).uniq.sort
    update(route_colors: route_colors)
  end

  def red_line?
    route_colors.include?("MLR")
  end

  def blue_line?
    route_colors.include?("MLB")
  end

  def both_lines?
    red_line? && blue_line?
  end

  def single_line?
    !both_lines?
  end

  def single_line_color
    return "MLR" if red_line?
    return "MLB" if blue_line?
  end
end
