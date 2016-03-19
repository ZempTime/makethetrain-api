class TransitsController < ApplicationController

  def new
  end

  def show
    from = Stop.where(stop_id: params[:from]).first
    to = Stop.where(stop_id: params[:to]).first
    bfs = BreadthFirstSearch.new(from, to)
    @segments = []


    bfs.segments.each do |segment|
      trips = segment[:from].trips.where(direction_id: segment[:direction]).pluck(:trip_id)
      segment[:stop_times] = segment[:from].stop_times.older_than(DateTime.now.seconds_since_midnight).where(trip_id: trips).order(seconds_since_midnight: :asc).first(20).pluck(:seconds_since_midnight).uniq
      today_in_seconds = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
      segment[:stop_times].collect! { |ssm| (today_in_seconds + ssm) * 1000 } # convert to milliseconds
      @segments.push segment
    end
  end
end
