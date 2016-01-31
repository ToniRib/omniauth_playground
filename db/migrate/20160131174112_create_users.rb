class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :map_my_fitness_id
      t.datetime :birthdate
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :username
      t.string :time_zone

      t.timestamps null: false
    end

    add_index :users, :map_my_fitness_id
    add_index :users, :username
  end
end
