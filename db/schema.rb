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

ActiveRecord::Schema[7.2].define(version: 2024_11_12_073615) do
  create_table "stocks", force: :cascade do |t|
    t.string "identifier"
    t.decimal "change"
    t.decimal "day_high"
    t.decimal "day_low"
    t.decimal "last_price"
    t.datetime "last_update_time"
    t.decimal "open"
    t.decimal "p_change"
    t.decimal "per_change_30d"
    t.decimal "per_change_365d"
    t.decimal "previous_close"
    t.string "symbol"
    t.decimal "total_traded_value"
    t.decimal "total_traded_volume"
    t.decimal "year_high"
    t.decimal "year_low"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_teams_on_username", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.string "type", null: false
    t.integer "source_wallet_id"
    t.integer "target_wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance", precision: 15, scale: 2, default: "0.0"
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id"], name: "index_wallets_on_entity"
  end
end
