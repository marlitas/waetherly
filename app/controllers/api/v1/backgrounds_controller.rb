class Api::V1::BackgroundsController < ApplicationController
  skip_before_action :require_authentication
  
  def index
    image = UnsplashFacade.get_image(params[:location])
    render json: ImageSerializer.new(image)
  end
end
