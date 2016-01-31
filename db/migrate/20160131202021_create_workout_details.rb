class CreateWorkoutDetails < ActiveRecord::Migration
  def change
    create_table :workout_details do |t|
      t.integer :time
      t.float :latitude
      t.float :longitude
      t.float :elevation
      t.float :speed
      t.float :distance
      t.references :workout, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
