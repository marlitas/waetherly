class Api::V1::SessionsController < ApplicationController
  include Authenticatable

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      api_key = user.api_keys.create! token: SecureRandom.hex
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    end
  end
end
