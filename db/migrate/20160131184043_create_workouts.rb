class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :map_my_fitness_id
      t.string :name
      t.datetime :updated_datetime
      t.datetime :created_datetime
      t.string :time_zone
      t.float :total_active_time
      t.float :total_distance
      t.float :average_speed
      t.float :total_elapsed_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :workouts, :map_my_fitness_id
  end
end
