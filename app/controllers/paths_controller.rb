class PathsController < ApplicationController
  before_action :validate_params

  def reveal
    render json: {"response" => "nice"}
  end

  private
    def validate_params
      unless (params.keys.include?("from") && params.keys.include?("to"))
        render json: { "error" => "Please include both a 'from' and a 'to' query parameter. " }
      end
    end
end
