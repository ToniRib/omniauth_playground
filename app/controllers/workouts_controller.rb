class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts.all
  end

  def create
    auth_token = session[:auth_token]

    token = OAuth2::AccessToken.new(mmf_client, auth_token)

    offset = 0
    next_flag = false
    until next_flag do
      workouts = token.get("/v7.0/workout/?user=#{current_user.map_my_fitness_id}",
                           :params => { limit: 40, offset: offset },
                           :headers => { 'Api-Key' => ENV['MMF_API_KEY'],
                                        'Authorization' => auth_token }).body

      workout_data = JSON.parse(workouts)
      WorkoutCreator.parse_and_create(workout_data["_embedded"]["workouts"], current_user.id)

      offset += 40
      next_flag = true if workout_data["_links"]["next"].nil?
    end

    redirect_to workouts_path
  end

  private

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
