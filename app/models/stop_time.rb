class StopTime < ApplicationRecord
  validates_presence_of :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence
  belongs_to :trip, primary_key: :trip_id
  belongs_to :stop, primary_key: :stop_id, required: false

  scope :older_than, -> (seconds) { where("seconds_since_midnight > ?", seconds)}

  # pp StopTime.joins(:trip).where(trips: { direction_id: "0", service_id: Calendar.active_today.service_id }).where(stop_id: "14753").older_than(DateTime.now.seconds_since_midnight).order(:seconds_since_midnight).first(6)

  def self.next(from, direction, number)
    if from.is_a? Stop
      from_id = from.stop_id
    else
      from_id = from
    end

    StopTime.joins(:trip).where(trips: { direction_id: direction, service_id: Calendar.active_today.service_id }).where(stop_id: from_id).older_than(DateTime.now.seconds_since_midnight).order(:seconds_since_midnight).first(number.to_i)
  end

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
