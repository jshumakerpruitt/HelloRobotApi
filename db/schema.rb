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

ActiveRecord::Schema.define(version: 20160910154759) do

  create_table "user_likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "liked_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["liked_user_id"], name: "index_user_likes_on_liked_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.integer  "age"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar"
    t.boolean  "verified"
    t.datetime "token_date"
    t.datetime "token_timestamp"
    t.string   "gender"
  end

end
