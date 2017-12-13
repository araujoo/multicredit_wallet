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

ActiveRecord::Schema.define(version: 20171213000739) do

  create_table "CreditCards_Purchases", id: false, force: :cascade do |t|
    t.integer "purchase_id",    null: false
    t.integer "credit_card_id", null: false
    t.index ["credit_card_id", "purchase_id"], name: "index_CreditCards_Purchases_on_credit_card_id_and_purchase_id"
    t.index ["purchase_id", "credit_card_id"], name: "index_CreditCards_Purchases_on_purchase_id_and_credit_card_id"
  end

  create_table "card_wallets", force: :cascade do |t|
    t.string   "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_card_wallets_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "card_nr"
    t.string   "print_name"
    t.integer  "billing_date"
    t.integer  "expire_month"
    t.string   "cvv"
    t.string   "limit"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "used_credit"
    t.integer  "expire_year"
    t.integer  "billing_month"
    t.integer  "card_wallet_id"
    t.index ["card_wallet_id"], name: "index_credit_cards_on_card_wallet_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "card_wallet_id"
    t.index ["card_wallet_id"], name: "index_purchases_on_card_wallet_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cpf"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "authentication_token", limit: 30
    t.string   "encrypted_password"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  end

end
