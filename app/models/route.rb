class Route < ApplicationRecord
  validates_presence_of :route_id, :route_short_name, :route_long_name
end
