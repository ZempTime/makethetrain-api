class UserTripsController < ApplicationController
  def new
    build_user_trip
  end

  def create
    build_user_trip
    save_user_trip or 'new'
  end

  def show
    load_user_trip
    @user_trip.calculate_segments
  end

  private
    def load_user_trip
      @user_trip = user_trip_scoped.find(params[:id])
    end

    def user_trip_params
      user_trip_params ||= params[:user_trip]
      user_trip_params ? user_trip_params.permit(:from_id, :to_id, :delay, :departed_at, :user_uid) : {}
    end

    def build_user_trip
      @user_trip ||= user_trip_scoped.build
      @user_trip.attributes = user_trip_params
    end

    def save_user_trip
      @user_trip.departure_at = DateTime.now
      if @user_trip.save
        redirect_to user_trip_path(@user_trip)
      end
    end

    def user_trip_scoped
      if Rails.env.development?
        UserTrip.all
      elsif params[:user_uid].presence
        UserTrip.where(user_uid: params[:user_uid])
      else
        UserTrip.all #perhaps scope this down to #none later but for now doesnt matter
      end
    end
end
