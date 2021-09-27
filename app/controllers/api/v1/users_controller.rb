class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.create(user_params)
    new_user.api_keys.create(token: SecureRandom.hex)
    render json: UsersSerializer.new(new_user)
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
