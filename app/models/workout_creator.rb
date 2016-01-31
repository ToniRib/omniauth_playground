class WorkoutCreator
  def self.parse_and_create(workouts, user_id)
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
        user_id: user_id
      )
    end
  end
end
