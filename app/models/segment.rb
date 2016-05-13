class Segment
  attr_accessor :from, :to, :direction, :next_stoptime, :segment_number

  def initialize(from, to, segment_number)
    @from = from
    @to = to
    @segment_number = segment_number
  end

  def direction
    @direction ||= calculate_direction
  end

  def calculate_direction
    if from.single_line?
      set_direction(from.single_line_color, from, to)
    elsif to.single_line?
      set_direction(to.single_line_color, from, to)
    else
      set_direction(from.single_line_color, from, to)
    end
  end

  def next_arrival_at
    today_in_seconds = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
    (@next_stoptime.seconds_since_midnight + today_in_seconds) * 1000
  end

  def next_stoptimes
    trips = @from.trips.where(direction_id: @direction).pluck(:trip_id)
    @next_stoptime =
      @from.stop_times.older_than(DateTime.now.seconds_since_midnight)
      .where(trip_id: trips)
      .order(seconds_since_midnight: :asc)
  end

  def set_direction(color, from, to)
    color = color.downcase
    line = self.class.send(color)
    if line.index(from.stop_id) < line.index(to.stop_id)
      return "0" # going east
    else
      return "1" # going west
    end
  end

  def self.mlr
    # west to east
    [
      "10634", "10633", "10632", "10631", "10630", "10629", "10628", "10627",
      "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619",
      "10618", "10617", "10616", "10599", "10600", "10601", "10602", "10603",
      "10604", "10605", "11103", "14274"
    ]
  end

  def self.mlb
    # west to east
    [
      "14753", "14754", "14755", "14756", "14757", "14758", "14759", "14760",
      "14761", "10626", "10625", "10624", "10623", "10622", "13662", "10620",
      "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602"
    ]
  end
end
