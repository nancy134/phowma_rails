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

ActiveRecord::Schema.define(version: 20180501122329) do

  create_table "admins", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "admins_area_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_admins_area_codes_on_state_id"
  end

  create_table "admins_campaigns", force: :cascade do |t|
    t.integer  "politician_id"
    t.integer  "election_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "admins_districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "number"
    t.decimal  "longitude1"
    t.decimal  "longitude2"
    t.decimal  "latitude1"
    t.decimal  "latitude2"
    t.index ["state_id"], name: "index_admins_districts_on_state_id"
  end

  create_table "admins_districts_zips", id: false, force: :cascade do |t|
    t.integer "district_id", null: false
    t.integer "zip_id",      null: false
    t.index ["district_id"], name: "index_admins_districts_zips_on_district_id"
    t.index ["zip_id"], name: "index_admins_districts_zips_on_zip_id"
  end

  create_table "admins_election_results", force: :cascade do |t|
    t.integer  "party"
    t.integer  "election_id"
    t.integer  "state_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["election_id"], name: "index_admins_election_results_on_election_id"
    t.index ["state_id"], name: "index_admins_election_results_on_state_id"
  end

  create_table "admins_elections", force: :cascade do |t|
    t.integer  "position"
    t.integer  "year"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "date"
    t.integer  "state_id"
    t.integer  "district_id"
    t.integer  "politician_id"
    t.integer  "election_type"
    t.string   "wikipedia"
    t.integer  "office_id"
    t.index ["district_id"], name: "index_admins_elections_on_district_id"
    t.index ["office_id"], name: "index_admins_elections_on_office_id"
    t.index ["politician_id"], name: "index_admins_elections_on_politician_id"
    t.index ["state_id"], name: "index_admins_elections_on_state_id"
  end

  create_table "admins_offices", force: :cascade do |t|
    t.integer  "position"
    t.integer  "state_id"
    t.integer  "district_id"
    t.integer  "politician_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["district_id"], name: "index_admins_offices_on_district_id"
    t.index ["politician_id"], name: "index_admins_offices_on_politician_id"
    t.index ["state_id"], name: "index_admins_offices_on_state_id"
  end

  create_table "admins_politicians", force: :cascade do |t|
    t.string   "name"
    t.integer  "party"
    t.integer  "state_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "position"
    t.integer  "district_id"
    t.string   "picture"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "attribution"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "latest_social"
    t.integer  "office_status"
    t.index ["district_id"], name: "index_admins_politicians_on_district_id"
    t.index ["state_id"], name: "index_admins_politicians_on_state_id"
  end

  create_table "admins_posts", force: :cascade do |t|
    t.string   "message"
    t.string   "image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "politician_id"
    t.datetime "social_date"
    t.string   "social_id"
    t.integer  "social_type"
    t.index ["politician_id"], name: "index_admins_posts_on_politician_id"
  end

  create_table "admins_settings", force: :cascade do |t|
    t.string   "facebook_token"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "admins_states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "registered"
  end

  create_table "admins_zips", force: :cascade do |t|
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_admins_zips_on_code"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "web"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "users_contacts", force: :cascade do |t|
    t.string   "phone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["phone_id"], name: "index_users_contacts_on_phone_id"
    t.index ["user_id"], name: "index_users_contacts_on_user_id"
  end

end
