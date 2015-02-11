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

ActiveRecord::Schema.define(version: 20141126173355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lessons", force: true do |t|
    t.date     "day"
    t.time     "start_time"
    t.integer  "duration"
    t.string   "status",     default: "available"
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "skype_id"
    t.string   "gmail_address"
    t.string   "preference"
  end

  create_table "tutors", force: true do |t|
    t.string   "name"
    t.string   "format"
    t.decimal  "price"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "undergraduate_institution"
    t.string   "undergraduate_major"
    t.string   "graduate_institution"
    t.string   "graduate_study_field"
    t.text     "subject"
    t.text     "long_bio"
    t.string   "skype_id"
    t.string   "gmail_address"
    t.text     "languages"
    t.boolean  "completed_profile",         default: false
    t.string   "routing_number"
    t.string   "account_number"
    t.string   "paypal_account"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_type"
    t.integer  "profile_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
