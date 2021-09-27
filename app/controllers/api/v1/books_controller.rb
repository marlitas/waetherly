class Api::V1::BooksController < ApplicationController
  def index
    location = MapService.get_location(params[:location])
    forecast = WeatherFacade.get_forecast_snippet(location)
    books = BookFacade.get_books(params[:location], params[:quantity])
  end
end
