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

ActiveRecord::Schema.define(version: 20150711162030) do

  create_table "requests", force: :cascade do |t|
    t.string   "type"
    t.datetime "created"
    t.datetime "expires"
    t.decimal  "longtitude"
    t.decimal  "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "number"
    t.integer  "credits",    default: 0
    t.decimal  "cash",       default: 0.0
    t.decimal  "reputation", default: 0.0
    t.integer  "requested",  default: 0
    t.integer  "received",   default: 0
    t.integer  "voteUp",     default: 0
    t.integer  "voteDown",   default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
