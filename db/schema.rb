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

ActiveRecord::Schema.define(version: 20151214023154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_issuers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "card_issuers", ["name"], name: "index_card_issuers_on_name", unique: true, using: :btree

  create_table "gift_cards", force: :cascade do |t|
    t.integer  "card_issuer_id"
    t.string   "card_number"
    t.integer  "balance_cents",    default: 0,     null: false
    t.string   "balance_currency", default: "USD", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "gift_cards", ["card_issuer_id"], name: "index_gift_cards_on_card_issuer_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "gift_card_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "transactions", ["gift_card_id"], name: "index_transactions_on_gift_card_id", using: :btree

  add_foreign_key "gift_cards", "card_issuers"
  add_foreign_key "transactions", "gift_cards"
end
