class ApplicationController < ActionController::API
  before_action :require_authentication

  def current_user
    User.find(session[:user_id]) if !session[:user_id].nil?
  end

  def require_authentication
    if current_user.nil?
      render json: {error: 'Unauthorized request'}, status: 401
    elsif !current_user.api_keys.pluck(:token).include?(params[:api_key])
      render json: {error: 'Unauthorized request'}, status: 401
    end
  end
end
