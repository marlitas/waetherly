class Api::V1::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation] || params[:email].empty?
      new_user = User.create(user_params)
      if new_user.id.nil?
        render json: {error: 'Email already exists'}, status: :conflict
      else
        new_user.api_keys.create(token: SecureRandom.hex)
        render json: UsersSerializer.new(new_user), status: :created
      end
    else
      render json: {error: 'Passwords do not match'}, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
