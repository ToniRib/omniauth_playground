class Workout < ActiveRecord::Base
  belongs_to :user

  def elapsed_time_in_minutes
    (total_elapsed_time / 60).round(2)
  end

  def active_time_in_minutes
    (total_active_time / 60).round(2)
  end
end
