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

ActiveRecord::Schema.define(version: 20161231185131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rides", force: :cascade do |t|
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer  "departure_delay"
    t.integer  "arrival_delay"
    t.integer  "departure_station_id"
    t.integer  "arrival_station_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["arrival_station_id"], name: "index_rides_on_arrival_station_id", using: :btree
    t.index ["departure_station_id"], name: "index_rides_on_departure_station_id", using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
