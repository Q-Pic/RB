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

ActiveRecord::Schema.define(version: 20150622170653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "guess"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "correct",    default: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "user_id"
    t.string   "answer"
    t.string   "hint"
    t.integer  "solved"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "owner"
    t.string   "solved_by"
    t.integer  "attempts",     default: 0
    t.integer  "times_solved", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "password"
    t.string   "access_token"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "points",          default: 0
    t.integer  "guess_count",     default: 0
    t.integer  "incorrect_count", default: 0
    t.integer  "correct_count",   default: 0
    t.float    "win_percent",     default: 0.0
  end

end
