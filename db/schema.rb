# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_22_000001) do
  create_table "dead_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "day", null: false
    t.bigint "dead_room_id", null: false
    t.integer "owner", default: 0, null: false
    t.bigint "player_id"
    t.datetime "updated_at", null: false
    t.index ["dead_room_id"], name: "index_dead_posts_on_dead_room_id"
    t.index ["player_id"], name: "index_dead_posts_on_player_id"
  end

  create_table "dead_rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "village_id", null: false
    t.index ["village_id"], name: "index_dead_rooms_on_village_id"
  end

  create_table "main_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "day", null: false
    t.bigint "main_room_id", null: false
    t.integer "owner", default: 0, null: false
    t.bigint "player_id"
    t.datetime "updated_at", null: false
    t.index ["main_room_id"], name: "index_main_posts_on_main_room_id"
    t.index ["player_id"], name: "index_main_posts_on_player_id"
  end

  create_table "main_rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "village_id", null: false
    t.index ["village_id"], name: "index_main_rooms_on_village_id"
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "role", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "username", null: false
    t.bigint "village_id", null: false
    t.index ["user_id"], name: "index_players_on_user_id"
    t.index ["village_id"], name: "index_players_on_village_id"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "attack_target_id"
    t.datetime "created_at", null: false
    t.integer "day", null: false
    t.bigint "divine_target_id"
    t.bigint "guard_target_id"
    t.bigint "player_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "village_id", null: false
    t.bigint "vote_target_id"
    t.index ["attack_target_id"], name: "index_records_on_attack_target_id"
    t.index ["divine_target_id"], name: "index_records_on_divine_target_id"
    t.index ["guard_target_id"], name: "index_records_on_guard_target_id"
    t.index ["player_id"], name: "index_records_on_player_id"
    t.index ["village_id"], name: "index_records_on_village_id"
    t.index ["vote_target_id"], name: "index_records_on_vote_target_id"
  end

  create_table "results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "attacked_player_id"
    t.datetime "created_at", null: false
    t.integer "day", null: false
    t.bigint "divined_player_id"
    t.bigint "guarded_player_id"
    t.datetime "updated_at", null: false
    t.bigint "village_id", null: false
    t.bigint "voted_player_id"
    t.index ["attacked_player_id"], name: "index_results_on_attacked_player_id"
    t.index ["divined_player_id"], name: "index_results_on_divined_player_id"
    t.index ["guarded_player_id"], name: "index_results_on_guarded_player_id"
    t.index ["village_id"], name: "index_results_on_village_id"
    t.index ["voted_player_id"], name: "index_results_on_voted_player_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "villages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "access_password"
    t.datetime "created_at", null: false
    t.integer "day", default: 0, null: false
    t.integer "discussion_time", null: false
    t.string "name", null: false
    t.datetime "next_update_time"
    t.integer "player_num", null: false
    t.boolean "show_vote_target", default: true, null: false
    t.datetime "start_at"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "winner"
    t.index ["user_id"], name: "index_villages_on_user_id"
  end

  create_table "wolf_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "day", null: false
    t.integer "owner", default: 0, null: false
    t.bigint "player_id"
    t.datetime "updated_at", null: false
    t.bigint "wolf_room_id", null: false
    t.index ["player_id"], name: "index_wolf_posts_on_player_id"
    t.index ["wolf_room_id"], name: "index_wolf_posts_on_wolf_room_id"
  end

  create_table "wolf_rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "village_id", null: false
    t.index ["village_id"], name: "index_wolf_rooms_on_village_id"
  end

  add_foreign_key "dead_posts", "dead_rooms"
  add_foreign_key "dead_posts", "players"
  add_foreign_key "dead_rooms", "villages"
  add_foreign_key "main_posts", "main_rooms"
  add_foreign_key "main_posts", "players"
  add_foreign_key "main_rooms", "villages"
  add_foreign_key "players", "users"
  add_foreign_key "players", "villages"
  add_foreign_key "profiles", "users"
  add_foreign_key "records", "players"
  add_foreign_key "records", "players", column: "attack_target_id"
  add_foreign_key "records", "players", column: "divine_target_id"
  add_foreign_key "records", "players", column: "guard_target_id"
  add_foreign_key "records", "players", column: "vote_target_id"
  add_foreign_key "records", "villages"
  add_foreign_key "results", "players", column: "attacked_player_id"
  add_foreign_key "results", "players", column: "divined_player_id"
  add_foreign_key "results", "players", column: "guarded_player_id"
  add_foreign_key "results", "players", column: "voted_player_id"
  add_foreign_key "results", "villages"
  add_foreign_key "villages", "users"
  add_foreign_key "wolf_posts", "players"
  add_foreign_key "wolf_posts", "wolf_rooms"
  add_foreign_key "wolf_rooms", "villages"
end
