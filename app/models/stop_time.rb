class StopTime < ApplicationRecord
  validates_presence_of :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence
  belongs_to :trip, primary_key: :trip_id
  belongs_to :stop, primary_key: :stop_id

  def route
    trip.route
  end

  def self.calculate_seconds_since_midnight
    all.each do |st|
      st.update(seconds_since_midnight: DateTime.parse(StopTime.first.departure_time).seconds_since_midnight)
    end
  end
end
