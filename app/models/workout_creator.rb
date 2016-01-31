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
      workouts = token.get("/v7.0/workout/?user=#{user.map_my_fitness_id}",
                           :params => { limit: 40, offset: offset },
                           :headers => { 'Api-Key' => ENV['MMF_API_KEY'],
                                         'Authorization' => auth_token }).body

      workout_data = JSON.parse(workouts)
      parse_and_create(workout_data["_embedded"]["workouts"])

      offset += 40
      next_flag = true if workout_data["_links"]["next"].nil?
    end

    import_workout_details
  end

  def parse_and_create(workouts)
    workouts.each do |workout|
      next if workout["aggregates"]["active_time_total"].zero?

      unless Workout.find_by(map_my_fitness_id: workout["_links"]["self"][0]["id"])
        Workout.create(
          map_my_fitness_id: workout["_links"]["self"][0]["id"],
          name: workout["name"][0],
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

  def import_workout_details
    Workout.where(user_id: user.id).limit(5).each do |workout|
      details = token.get("/v7.1/workout/#{workout.map_my_fitness_id}/?field_set=time_series",
                          :headers => { 'Api-Key' => ENV['MMF_API_KEY'],
                                        'Authorization' => auth_token }).body
      details = JSON.parse(details)

      next if details["has_time_series"] == false

      details["time_series"]["position"].each do |set|
        time = set[0]

        if details["time_series"]["speed"][0][0] == time
          speed = details["time_series"]["speed"][0][1]
        else
          speed = 0
        end

        if details["time_series"]["distance"][0][0] == time
          distance = details["time_series"]["distance"][0][1]
        else
          distance = 0
        end

        WorkoutDetail.create(
          time: set[0],
          latitude: set[1]["lat"],
          longitude: set[1]["lng"],
          elevation: set[1]["elevation"],
          speed: speed,
          distance: distance,
          workout_id: workout.id
        )
      end
    end
  end
end
