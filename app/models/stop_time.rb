class StopTime < ApplicationRecord
  validates_presence_of :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence
  belongs_to :trip, primary_key: :trip_id
  belongs_to :stop, primary_key: :stop_id

  def route
    trip.route
  end
end
