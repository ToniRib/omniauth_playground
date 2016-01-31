class WorkoutDetail < ActiveRecord::Base
  belongs_to :workout

  def coordinates
    { lat: latitude, lng: longitude }
  end
end
