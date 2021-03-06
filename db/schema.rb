# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160131202021) do

  create_table "users", force: :cascade do |t|
    t.integer  "map_my_fitness_id"
    t.datetime "birthdate"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "username"
    t.string   "time_zone"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "users", ["map_my_fitness_id"], name: "index_users_on_map_my_fitness_id"
  add_index "users", ["username"], name: "index_users_on_username"

  create_table "workout_details", force: :cascade do |t|
    t.integer  "time"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "elevation"
    t.float    "speed"
    t.float    "distance"
    t.integer  "workout_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "workout_details", ["workout_id"], name: "index_workout_details_on_workout_id"

  create_table "workouts", force: :cascade do |t|
    t.integer  "map_my_fitness_id"
    t.string   "name"
    t.datetime "updated_datetime"
    t.datetime "created_datetime"
    t.string   "time_zone"
    t.float    "total_active_time"
    t.float    "total_distance"
    t.float    "average_speed"
    t.float    "total_elapsed_time"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "workouts", ["map_my_fitness_id"], name: "index_workouts_on_map_my_fitness_id"
  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id"

end
