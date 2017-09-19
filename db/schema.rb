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

ActiveRecord::Schema.define(version: 20170911193754) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "content",     limit: 65535
    t.boolean  "is_correct"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "attempts", force: :cascade do |t|
    t.integer  "student_id",         limit: 4
    t.integer  "number_of_attempts", limit: 4
    t.integer  "quiz_id",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "courses", id: false, force: :cascade do |t|
    t.string   "id",         limit: 8,  null: false
    t.string   "name",       limit: 35
    t.string   "user_id",    limit: 8,  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "courses", ["id"], name: "index_courses_on_id", unique: true, using: :btree

  create_table "educators", force: :cascade do |t|
    t.string   "user_id",    limit: 8
    t.string   "first_name", limit: 25
    t.string   "last_name",  limit: 25
    t.string   "role",       limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "enrolleds", force: :cascade do |t|
    t.integer  "student_id",  limit: 4,             null: false
    t.string   "course_id",   limit: 8,             null: false
    t.integer  "status_type", limit: 4, default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "learning_outcomes", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.string   "course_id",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "quiz_id",             limit: 4
    t.text     "content",             limit: 65535
    t.integer  "learning_outcome_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "course_id",        limit: 255
    t.integer  "status_type",      limit: 4
    t.integer  "number_questions", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "answer_id",   limit: 4
    t.integer  "student_id",  limit: 4
    t.integer  "attempt_id",  limit: 4
    t.boolean  "is_correct"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "user_id",    limit: 8,  null: false
    t.string   "first_name", limit: 25
    t.string   "last_name",  limit: 25
    t.string   "year",       limit: 12
    t.string   "degree",     limit: 35
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string   "id",                     limit: 8,                null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.integer  "role_type",              limit: 4,   default: 0,  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["id"], name: "index_users_on_id", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
