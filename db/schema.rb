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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130716140154) do

  create_table "checkins", :force => true do |t|
    t.integer  "route_id"
    t.integer  "location_id"
    t.datetime "stamp"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "device_id"
  end

  add_index "checkins", ["device_id"], :name => "index_checkins_on_device_id"
  add_index "checkins", ["location_id"], :name => "index_checkins_on_location_id"
  add_index "checkins", ["route_id"], :name => "index_checkins_on_route_id"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "radius"
    t.string   "country_code"
    t.string   "state_province"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "gmaps"
  end

  create_table "devices", :force => true do |t|
    t.string   "identifier"
    t.string   "platform"
    t.string   "platform_version"
    t.string   "default_language"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "devices", ["identifier"], :name => "index_devices_on_identifier"
  add_index "devices", ["user_id"], :name => "index_devices_on_user_id"

  create_table "location_translations", :force => true do |t|
    t.integer  "location_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "location_translations", ["locale"], :name => "index_location_translations_on_locale"
  add_index "location_translations", ["location_id"], :name => "index_location_translations_on_location_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "name_nl"
    t.text     "description_nl"
    t.decimal  "latitude",       :precision => 12, :scale => 9
    t.decimal  "longitude",      :precision => 12, :scale => 9
    t.string   "address"
    t.string   "city"
    t.string   "postal_code"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "gmaps"
    t.string   "image"
  end

  create_table "reward_translations", :force => true do |t|
    t.integer  "reward_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reward_translations", ["locale"], :name => "index_reward_translations_on_locale"
  add_index "reward_translations", ["reward_id"], :name => "index_reward_translations_on_reward_id"

  create_table "rewards", :force => true do |t|
    t.string   "name"
    t.string   "name_nl"
    t.text     "description"
    t.text     "description_nl"
    t.string   "image"
    t.string   "rewardable_type"
    t.integer  "rewardable_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "route_profile_translations", :force => true do |t|
    t.integer  "route_profile_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "route_profile_translations", ["locale"], :name => "index_route_profile_translations_on_locale"
  add_index "route_profile_translations", ["route_profile_id"], :name => "index_route_profile_translations_on_route_profile_id"

  create_table "route_profiles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "name_nl"
    t.text     "description_nl"
    t.string   "icon"
    t.string   "image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "is_publishable"
  end

  create_table "route_translations", :force => true do |t|
    t.integer  "route_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "route_translations", ["locale"], :name => "index_route_translations_on_locale"
  add_index "route_translations", ["route_id"], :name => "index_route_translations_on_route_id"

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "name_nl"
    t.text     "description_nl"
    t.string   "icon"
    t.string   "image"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "route_profile_id"
    t.boolean  "is_publishable"
  end

  add_index "routes", ["route_profile_id"], :name => "index_routes_on_route_profile_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "waypoints", :force => true do |t|
    t.integer  "route_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "rank"
  end

  add_index "waypoints", ["location_id"], :name => "index_waypoints_on_location_id"
  add_index "waypoints", ["route_id"], :name => "index_waypoints_on_route_id"

end
