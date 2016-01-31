class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts.all
  end

  def create
    token = OAuth2::AccessToken.new(mmf_client, session[:auth_token])

    WorkoutCreator.new(token, session[:auth_token], current_user.id)

    redirect_to workouts_path
  end

  def show
    @workout = Workout.find(params[:id])
  end
end
