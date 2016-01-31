class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def mmf_client
    OAuth2::Client.new(
      ENV['MMF_API_KEY'],
      ENV['MMF_SECRET_KEY'],
      :authorize_url => "https://www.mapmyfitness.com/v7.0/oauth2/authorize/",
      :token_url => "https://oauth2-api.mapmyapi.com/v7.0/oauth2/access_token/",
      :site => "https://oauth2-api.mapmyapi.com"
    )
  end
end
