class Api::V1::UsersController < ApplicationController
  def create
    require "pry";binding.pry
    if params[:password] == params[:password_confirmation]
      new_user = User.create(user_params)
    else

    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
