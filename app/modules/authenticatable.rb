module Authenticatable
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_user

  def authenticate_with_api_key
    require "pry";binding.pry
    @current_user = auethenticate_or_request_with_http_token &method(authenticator)
  end

  def authenticate_with_api_key
    require "pry";binding.pry
    @current_user = authenticate_with_http_token &method(:authenticator)
  end

  private

  attr_writer :current_api_key
  attr_writer :current_user

  def authenticator(http_token, options)
    require "pry";binding.pry
    @current_api_key = ApiKey.find_by token: http_token

    current_api_key&.user
  end
end
