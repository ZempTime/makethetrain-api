class Api::ItinerariesController < ApplicationController
  before_action :validate_params

  def calculate
    from = Stop.where(stop_id: params[:from]).first
    to = Stop.where(stop_id: params[:to]).first
    bfs = BreadthFirstSearch.new(from, to)
    @response = []


    bfs.segments.each do |segment|
      trips = segment[:from].trips.where(direction_id: segment[:direction]).pluck(:trip_id)
      segment[:stop_times] = segment[:from].stop_times.older_than(DateTime.now.seconds_since_midnight).where(trip_id: trips).order(seconds_since_midnight: :asc).first(20).pluck(:departure_time)
      @response.push segment
    end

    render json: @response
  end

  private
    def validate_params
      unless (params.keys.include?("from") && params.keys.include?("to"))
        render json: { "error" => "invalid parameters", "message" => "Please include both a 'from' and a 'to' query parameter with stop_ids as values." }
      end
    end
end

# pp StopTime.joins(:trip).where(trips: { direction_id: "0" }).where(stop_id: "14753").older_than(DateTime.now.seconds_since_midnight).order(:seconds_since_midnight).first(6)
