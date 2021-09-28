class Api::V1::ForecastController < ApplicationController
  skip_before_action :require_authentication
  
   def index
     location = MapService.get_location(params[:location])
     forecast = WeatherFacade.get_forecast(location)
     render json: ForecastSerializer.new(forecast)
   end
end
