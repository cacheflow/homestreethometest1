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

ActiveRecord::Schema.define(version: 20140602205755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: true do |t|
    t.integer  "amount"
    t.integer  "donor_id"
    t.integer  "resident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["donor_id"], name: "index_donations_on_donor_id", using: :btree
  add_index "donations", ["resident_id"], name: "index_donations_on_resident_id", using: :btree

  create_table "donors", force: true do |t|
    t.string   "name"
    t.string   "org"
    t.string   "email"
    t.integer  "phone",         limit: 8
    t.boolean  "email_updates"
    t.boolean  "phone_updates"
    t.integer  "donations_id"
    t.integer  "resident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "donors", ["donations_id"], name: "index_donors_on_donations_id", using: :btree
  add_index "donors", ["resident_id"], name: "index_donors_on_resident_id", using: :btree

  create_table "partners", force: true do |t|
    t.string   "org"
    t.string   "address"
    t.integer  "phone",       limit: 8
    t.string   "email"
    t.string   "website"
    t.integer  "resident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "partners", ["resident_id"], name: "index_partners_on_resident_id", using: :btree

  create_table "residents", force: true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "bio"
    t.string   "goals"
    t.string   "goal_monetary"
    t.string   "amount_raised"
    t.integer  "partner_id"
    t.integer  "statuses_id"
    t.integer  "donors_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "residents", ["donors_id"], name: "index_residents_on_donors_id", using: :btree
  add_index "residents", ["partner_id"], name: "index_residents_on_partner_id", using: :btree
  add_index "residents", ["statuses_id"], name: "index_residents_on_statuses_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "content"
    t.integer  "resident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["resident_id"], name: "index_statuses_on_resident_id", using: :btree

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
    t.string   "role"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
