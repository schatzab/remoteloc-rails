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

ActiveRecord::Schema.define(version: 20160305060927) do

  create_table "cities", force: :cascade do |t|
    t.integer  "state_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "permalink",  limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["permalink"], name: "index_cities_on_permalink", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "cities_users", id: false, force: :cascade do |t|
    t.integer "city_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "cities_users", ["city_id", "user_id"], name: "index_cities_users_on_city_id_and_user_id", using: :btree

  create_table "loc_edits", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "loc_id",     limit: 4
    t.string   "summary",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loc_edits", ["user_id", "loc_id"], name: "index_loc_edits_on_user_id_and_loc_id", using: :btree

  create_table "locs", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",                  default: false
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "website",    limit: 255
    t.string   "user_city",  limit: 100
  end

  add_index "locs", ["city_id"], name: "index_locs_on_city_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 255, default: "",    null: false
    t.string   "username",        limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.boolean  "admin",                       default: false
  end

end
