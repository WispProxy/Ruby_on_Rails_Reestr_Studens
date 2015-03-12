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

ActiveRecord::Schema.define(version: 20150312174115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["student_id"], name: "index_ratings_on_student_id", using: :btree
  add_index "ratings", ["subject_id"], name: "index_ratings_on_subject_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "group_id"
    t.date     "date_of_birth"
    t.string   "email"
    t.string   "registration_ip"
    t.datetime "registration_time"
    t.text     "characteristic"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "students", ["group_id"], name: "index_students_on_group_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ratings", "students"
  add_foreign_key "ratings", "subjects"
  add_foreign_key "students", "groups"
end
