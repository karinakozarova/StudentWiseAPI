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

ActiveRecord::Schema.define(version: 2020_01_16_133232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "complaints", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "status", default: "sent", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_complaints_on_creator_id"
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
    t.bigint "creator_id"
    t.string "event_type", default: "other"
    t.string "title", default: "", null: false
    t.text "description", default: ""
    t.datetime "starts_at"
    t.datetime "finishes_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "event_status", default: "pending", null: false
    t.index ["creator_id"], name: "index_events_on_creator_id"
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
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
    t.index ["creator_id"], name: "index_expenses_on_creator_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "complaints", "users", column: "creator_id"
  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users", column: "participant_id"
  add_foreign_key "event_votes", "events"
  add_foreign_key "event_votes", "users", column: "voter_id"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "expense_participants", "expenses"
  add_foreign_key "expense_participants", "users", column: "participant_id"
  add_foreign_key "expenses", "users", column: "creator_id"
end
