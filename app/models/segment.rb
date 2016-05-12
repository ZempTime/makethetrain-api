class Segment
  attr_accessor :from, :to, :direction, :next_stoptime, :segment_number

  def initialize(args)
    @from = args[:from]
    @to = args[:to]
    @direction = args[:direction]
    @segment_number = args[:segment_number]
    set_next_stoptime
  end

  def next_arrival_at
    today_in_seconds = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
    (@next_stoptime.seconds_since_midnight + today_in_seconds) * 1000
  end

  def display_direction
    Direction.display(direction)
  end

    def set_next_stoptime
      trips = @from.trips.where(direction_id: @direction).pluck(:trip_id)
      @next_stoptime =
        @from.stop_times.older_than(DateTime.now.seconds_since_midnight)
        .where(trip_id: trips)
        .order(seconds_since_midnight: :asc)
        .first
    end
end
