class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    session[:auth_token] = auth_hash.credentials.token
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
