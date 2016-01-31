class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :workout_details

  def elapsed_time_in_minutes
    (total_elapsed_time / 60).round(2)
  end

  def active_time_in_minutes
    (total_active_time / 60).round(2)
  end

  def total_distance_in_miles
    (total_distance / 1609.34).round(2)
  end

  def average_speed_in_miles_per_hour
    (average_speed * 2.2369418519393043).round(2) if average_speed
  end

  def self.average_speed_for_distance_range(start_distance, end_distance)
    Workout.where("total_distance >= ? AND total_distance <= ?", start_distance, end_distance)
  end

  def route_coordinates
    workout_details.map { |point| point.coordinates }
  end

  def speeds
    workout_details.pluck(:speed)
  end

  def max_speed
    workout_details.maximum(:speed)
  end

  def min_speed
    workout_details.minimum(:speed)
  end
end
