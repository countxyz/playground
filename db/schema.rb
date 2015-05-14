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

ActiveRecord::Schema.define(version: 20150514020333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",                      null: false
    t.string   "website",    default: "",   null: false
    t.boolean  "active",     default: true, null: false
    t.string   "slug",                      null: false
    t.integer  "user_id"
  end

  add_index "accounts", ["created_at"], name: "index_accounts_on_created_at", using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", unique: true, using: :btree
  add_index "accounts", ["slug"], name: "index_accounts_on_slug", unique: true, using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "first_name",              null: false
    t.string   "last_name",               null: false
    t.string   "company",    default: "", null: false
    t.integer  "user_id"
  end

  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "address",        null: false
    t.integer  "emailable_id"
    t.string   "emailable_type"
  end

  add_index "emails", ["emailable_type", "emailable_id"], name: "index_emails_on_emailable_type_and_emailable_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "note",          null: false
    t.integer  "noteable_id"
    t.string   "noteable_type"
  end

  add_index "notes", ["noteable_type", "noteable_id"], name: "index_notes_on_noteable_type_and_noteable_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.decimal  "total",      precision: 8, scale: 2, default: 0.0
    t.integer  "status",                             default: 0
    t.integer  "user_id"
  end

  add_index "orders", ["created_at"], name: "index_orders_on_created_at", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "phone_number",   null: false
    t.string   "type",           null: false
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
  end

  add_index "phones", ["phoneable_type", "phoneable_id"], name: "index_phones_on_phoneable_type_and_phoneable_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.datetime "deadline"
    t.boolean  "complete",     default: true, null: false
    t.datetime "completed_at"
    t.integer  "user_id"
  end

  add_index "tasks", ["complete"], name: "index_tasks_on_complete", using: :btree
  add_index "tasks", ["created_at"], name: "index_tasks_on_created_at", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "email",                        null: false
    t.string   "first_name",      default: "", null: false
    t.string   "last_name",       default: "", null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
