class Trip < ApplicationRecord
  validates_presence_of :route_id, :trip_id, :trip_headsign, :service_id

  belongs_to :route, primary_key: :route_id
  belongs_to :calendar, class_name: "Calendar", foreign_key: :service_id
  has_many :stop_times, primary_key: :trip_id
  has_many :stops, through: :stop_times

end
