class StopTime < ApplicationRecord
  validates_presence_of :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence
  belongs_to :trip, primary_key: :trip_id
  belongs_to :stop, primary_key: :stop_id, required: false

  scope :older_than, -> (seconds) { where("seconds_since_midnight > ?", seconds)}

  def route
    trip.route
  end

  def self.calculate_seconds_since_midnight
    all.each do |st|
      t = st.departure_time.split(":")
      seconds_since_midnight = t.first.to_i.hours + t.second.to_i.minutes + t.third.to_i.seconds
      st.update(seconds_since_midnight: seconds_since_midnight)
    end
    true
  end
end
