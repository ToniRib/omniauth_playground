class UsersController < ApplicationController
  def show
    if current_user
      @user = current_user
    else
      render file: "public/404"
    end
  end
end
