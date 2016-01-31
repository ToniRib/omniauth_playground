class WorkoutCreator
  attr_reader :token, :auth_token, :user

  def initialize(token, auth_token, user_id)
    @token = token
    @auth_token = auth_token
    @user = User.find(user_id)

    create_workouts
  end

  def create_workouts
    offset = 0
    next_flag = false
    until next_flag do
      workouts = token.get("/v7.0/workout/?user=#{@user.map_my_fitness_id}",
                           :params => { limit: 40, offset: offset },
                           :headers => { 'Api-Key' => ENV['MMF_API_KEY'],
                                         'Authorization' => auth_token }).body

      workout_data = JSON.parse(workouts)
      parse_and_create(workout_data["_embedded"]["workouts"])

      offset += 40
      next_flag = true if workout_data["_links"]["next"].nil?
    end
  end

  def parse_and_create(workouts)
    workouts.each do |workout|
      next if workout["aggregates"]["active_time_total"].zero?

      Workout.create(
        map_my_fitness_id: workout["_links"]["self"][0]["id"],
        name: workout["name"],
        updated_datetime: Time.parse(workout["updated_datetime"]),
        created_datetime: Time.parse(workout["created_datetime"]),
        time_zone: workout["start_locale_timezone"],
        total_active_time: workout["aggregates"]["active_time_total"],
        total_distance: workout["aggregates"]["distance_total"],
        average_speed: workout["aggregates"]["speed_avg"],
        total_elapsed_time: workout["aggregates"]["elapsed_time_total"],
        user_id: user.id
      )
    end
  end
end
