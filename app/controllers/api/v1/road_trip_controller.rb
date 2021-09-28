class Api::V1::RoadTripController < ApplicationController
  def create
    trip_length = MapFacade.get_directions(params[:origin], params[:destination])
    if trip_length.nil?
      trip_length = 'impossible route'
    else
      destination = MapService.get_location(params[:destination])
      arrival_forecast = WeatherFacade.get_arrival_forecast(destination, trip_length)
    end
    render json: RoadtripSerializer.new(Roadtrip.new(params[:origin], params[:destination], trip_length, arrival_forecast))
  end
end
