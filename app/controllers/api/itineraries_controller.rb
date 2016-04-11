class Api::ItinerariesController < ApplicationController
  before_action :validate_params

  def calculate
    from = Stop.where(stop_id: params[:from]).first
    to = Stop.where(stop_id: params[:to]).first
    bfs = BreadthFirstSearch.new(from, to)
    @response = []

    bfs.segments.each do |segment|
      segment[:stop_times] = StopTime.next(segment[:from], segment[:direction], 20)
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
