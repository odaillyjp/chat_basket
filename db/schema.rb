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

ActiveRecord::Schema.define(version: 20160718042057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status",     null: false
    t.index ["room_id"], name: "index_attendances_on_room_id", using: :btree
    t.index ["status"], name: "index_attendances_on_status", using: :btree
    t.index ["user_id"], name: "index_attendances_on_user_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.string   "stock"
    t.integer  "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_games_on_room_id", using: :btree
    t.index ["winner_id"], name: "index_games_on_winner_id", using: :btree
  end

  create_table "hands", force: :cascade do |t|
    t.integer  "orner_id",   null: false
    t.string   "char",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id",    null: false
    t.index ["orner_id"], name: "index_hands_on_orner_id", using: :btree
  end

  create_table "layouts", force: :cascade do |t|
    t.integer  "game_id",    null: false
    t.string   "char",       null: false
    t.string   "word"
    t.integer  "orner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_layouts_on_game_id", using: :btree
    t.index ["orner_id"], name: "index_layouts_on_orner_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content",    null: false
    t.integer  "user_id",    null: false
    t.integer  "room_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "game_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "current_game_id"
    t.index ["current_game_id"], name: "index_rooms_on_current_game_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "rooms"
  add_foreign_key "attendances", "users"
  add_foreign_key "games", "rooms"
  add_foreign_key "layouts", "games"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
end
