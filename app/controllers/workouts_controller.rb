class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts.all
  end

  def create
    token = OAuth2::AccessToken.new(mmf_client, session[:auth_token])

    WorkoutCreator.new(token, session[:auth_token], current_user.id)

    # offset = 0
    # next_flag = false
    # until next_flag do
    #   workouts = token.get("/v7.0/workout/?user=#{current_user.map_my_fitness_id}",
    #                        :params => { limit: 40, offset: offset },
    #                        :headers => { 'Api-Key' => ENV['MMF_API_KEY'],
    #                                     'Authorization' => session[:auth_token] }).body
    #
    #   workout_data = JSON.parse(workouts)
    #   WorkoutCreator.parse_and_create(workout_data["_embedded"]["workouts"], current_user.id)
    #
    #   offset += 40
    #   next_flag = true if workout_data["_links"]["next"].nil?
    # end

    redirect_to workouts_path
  end

  def show
    @workout = Workout.find(params[:id])
  end
end
