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

ActiveRecord::Schema.define(version: 20160511220438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.string   "service_id"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string   "route_id"
    t.string   "route_short_name"
    t.string   "route_long_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stop_times", force: :cascade do |t|
    t.string   "trip_id"
    t.string   "arrival_time"
    t.string   "departure_time"
    t.string   "stop_id"
    t.integer  "stop_sequence"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "seconds_since_midnight"
  end

  create_table "stops", force: :cascade do |t|
    t.float    "stop_lat"
    t.float    "stop_lon"
    t.string   "stop_id"
    t.string   "stop_description"
    t.string   "stop_name"
    t.string   "location_type"
    t.string   "stop_code"
    t.string   "stop_desc"
    t.text     "route_colors"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string   "block_id"
    t.string   "route_id"
    t.string   "direction_id"
    t.string   "trip_headsign"
    t.string   "shape_id"
    t.string   "service_id"
    t.string   "trip_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_trips", force: :cascade do |t|
    t.string   "from_id"
    t.string   "to_id"
    t.integer  "user_uid"
    t.datetime "departure_at"
    t.integer  "delay",          default: 0
    t.integer  "segment_number", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
