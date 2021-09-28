class Api::V1::SessionsController < ApplicationController
  skip_before_action :require_authentication
  
  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      api_key = user.api_keys.create! token: SecureRandom.hex
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: {error: 'username or password incorrect'}, status: :bad_request
    end
  end
end
