class Api::V1::RoadTripController < ApplicationController
  def create
    if current_user.api_keys.pluck(:token).include?(params[:api_key])
      trip_length = MapFacade.get_directions(params[:origin], params[:destination])
      destination = MapService.get_location(params[:destination])
      arrival_forecast = WeatherFacade.get_arrival_forecast(destination, trip_length)

      render json: RoadtripSerializer.new(Roadtrip.new(params[:origin], params[:destination], trip_length, arrival_forecast))
    else

    end
  end
end
