# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_20_213202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreements", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id", null: false
    t.index ["creator_id"], name: "index_agreements_on_creator_id"
    t.index ["group_id"], name: "index_agreements_on_group_id"
  end

  create_table "complaints", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "status", default: "sent", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id", null: false
    t.index ["creator_id"], name: "index_complaints_on_creator_id"
    t.index ["group_id"], name: "index_complaints_on_group_id"
  end

  create_table "event_participants", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id", "participant_id"], name: "index_event_participants_on_event_id_and_participant_id", unique: true
    t.index ["event_id"], name: "index_event_participants_on_event_id"
    t.index ["participant_id"], name: "index_event_participants_on_participant_id"
  end

  create_table "event_votes", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "voter_id", null: false
    t.boolean "finished", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id", "voter_id"], name: "index_event_votes_on_event_id_and_voter_id", unique: true
    t.index ["event_id"], name: "index_event_votes_on_event_id"
    t.index ["voter_id"], name: "index_event_votes_on_voter_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "kind", default: "other", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "starts_at"
    t.datetime "finishes_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "pending", null: false
    t.bigint "group_id", null: false
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["group_id"], name: "index_events_on_group_id"
  end

  create_table "expense_participants", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id", "participant_id"], name: "index_expense_participants_on_expense_id_and_participant_id", unique: true
    t.index ["expense_id"], name: "index_expense_participants_on_expense_id"
    t.index ["participant_id"], name: "index_expense_participants_on_participant_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "name", null: false
    t.string "notes"
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
    t.bigint "group_id", null: false
    t.index ["creator_id"], name: "index_expenses_on_creator_id"
    t.index ["group_id"], name: "index_expenses_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "rules"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "admin", default: false, null: false
    t.bigint "group_id"
    t.boolean "two_fa_enabled", default: false
    t.string "two_fa_secret"
    t.string "two_fa_challenge"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  add_foreign_key "agreements", "groups"
  add_foreign_key "agreements", "users", column: "creator_id"
  add_foreign_key "complaints", "groups"
  add_foreign_key "complaints", "users", column: "creator_id"
  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users", column: "participant_id"
  add_foreign_key "event_votes", "events"
  add_foreign_key "event_votes", "users", column: "voter_id"
  add_foreign_key "events", "groups"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "expense_participants", "expenses"
  add_foreign_key "expense_participants", "users", column: "participant_id"
  add_foreign_key "expenses", "groups"
  add_foreign_key "expenses", "users", column: "creator_id"
  add_foreign_key "users", "groups"
end
