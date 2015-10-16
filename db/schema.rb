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

ActiveRecord::Schema.define(version: 20151016073950) do

  create_table "absences", force: :cascade do |t|
    t.date    "date"
    t.integer "duration", default: 8
    t.integer "reason",   default: 0, null: false
    t.integer "user_id"
  end

  create_table "timetracks", force: :cascade do |t|
    t.date     "date"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "pause"
    t.integer  "duration"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           default: "", null: false
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
