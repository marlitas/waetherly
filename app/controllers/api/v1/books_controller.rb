class Api::V1::BooksController < ApplicationController
  def index
    quantity = params[:quantity].to_i
    if params[:quantity] == quantity.to_s && quantity > 0
      location = MapService.get_location(params[:location])
      forecast = WeatherFacade.get_forecast_snippet(location)
      books = BookFacade.get_books(params[:location], quantity)
      render json: BooksSerializer.destination_books(books, forecast, params[:location])
    else
      render json: {error: 'quantity must be an integer greater than zero'}, status: :bad_request
    end
  end
end
