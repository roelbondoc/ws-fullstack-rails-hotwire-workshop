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

ActiveRecord::Schema[7.0].define(version: 2022_08_08_190451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "portfolio_id"
    t.string "canonical_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_accounts_on_client_id"
    t.index ["portfolio_id"], name: "index_accounts_on_portfolio_id"
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "security_id"
    t.string "activity_type"
    t.decimal "amount"
    t.datetime "posted_at"
    t.datetime "effective_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_activities_on_account_id"
    t.index ["security_id"], name: "index_activities_on_security_id"
  end

  create_table "allocations", force: :cascade do |t|
    t.bigint "portfolio_id"
    t.bigint "asset_class_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_class_id"], name: "index_allocations_on_asset_class_id"
    t.index ["portfolio_id"], name: "index_allocations_on_portfolio_id"
  end

  create_table "asset_class_securities", force: :cascade do |t|
    t.bigint "asset_class_id"
    t.bigint "security_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_class_id"], name: "index_asset_class_securities_on_asset_class_id"
    t.index ["security_id"], name: "index_asset_class_securities_on_security_id"
  end

  create_table "asset_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "postal"
    t.string "province"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "security_id"
    t.string "order_type"
    t.decimal "amount"
    t.datetime "posted_at"
    t.datetime "rejected_at"
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["security_id"], name: "index_orders_on_security_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "security_id"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_positions_on_account_id"
    t.index ["security_id"], name: "index_positions_on_security_id"
  end

  create_table "securities", force: :cascade do |t|
    t.string "symbol"
    t.decimal "buy_cost"
    t.decimal "sell_cost"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
