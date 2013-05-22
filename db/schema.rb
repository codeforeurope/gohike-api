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

ActiveRecord::Schema.define(:version => 20130522103322) do

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

  create_table "locations", :force => true do |t|
    t.string   "name_en"
    t.text     "description_en"
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
  end

  create_table "route_profiles", :force => true do |t|
    t.string   "name_en"
    t.text     "description_en"
    t.string   "name_nl"
    t.text     "description_nl"
    t.string   "icon"
    t.string   "image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "routes", :force => true do |t|
    t.string   "name_en"
    t.text     "description_en"
    t.string   "name_nl"
    t.text     "description_nl"
    t.string   "icon"
    t.string   "image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

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
    t.integer  "previous_location_id"
    t.integer  "next_location_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "waypoints", ["location_id"], :name => "index_waypoints_on_location_id"
  add_index "waypoints", ["next_location_id"], :name => "index_waypoints_on_next_location_id"
  add_index "waypoints", ["previous_location_id"], :name => "index_waypoints_on_previous_location_id"
  add_index "waypoints", ["route_id"], :name => "index_waypoints_on_route_id"

end
