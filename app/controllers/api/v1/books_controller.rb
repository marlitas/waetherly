class Api::V1::BooksController < ApplicationController
  def index
    location = MapService.get_location(params[:location])
    forecast = WeatherFacade.get_forecast_snippet(location)
    books = BookFacade.get_books(params[:location], params[:quantity].to_i)
    render json: BooksSerializer.destination_books(books, forecast, params[:location
  end
end
