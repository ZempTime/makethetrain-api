class Trip < ApplicationRecord
  validates_presence_of :route_id, :trip_id, :trip_headsign
  belongs_to :route, primary_key: :route_id
  has_many :stop_times, primary_key: :trip_id
  has_many :stops, through: :stop_times
end
