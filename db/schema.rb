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

ActiveRecord::Schema.define(version: 20160405231955) do

  create_table "attendances", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["room_id"], name: "index_attendances_on_room_id"
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id"

  create_table "games", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.string   "stock",      null: false
    t.integer  "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "games", ["room_id"], name: "index_games_on_room_id"
  add_index "games", ["winner_id"], name: "index_games_on_winner_id"

  create_table "layouts", force: :cascade do |t|
    t.integer  "game_id",    null: false
    t.string   "char",       null: false
    t.integer  "orner_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "layouts", ["game_id"], name: "index_layouts_on_game_id"
  add_index "layouts", ["orner_id"], name: "index_layouts_on_orner_id"

  create_table "messages", force: :cascade do |t|
    t.text     "content",    null: false
    t.integer  "user_id",    null: false
    t.integer  "room_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["room_id"], name: "index_messages_on_room_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "players", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "game_id",                 null: false
    t.string   "hand",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"
  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
