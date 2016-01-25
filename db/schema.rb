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

ActiveRecord::Schema.define(version: 20160125123018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charities", force: :cascade do |t|
    t.string   "name"
    t.integer  "justgiving_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "flags", force: :cascade do |t|
    t.integer  "memory_id"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "flags", ["memory_id"], name: "index_flags_on_memory_id", using: :btree
  add_index "flags", ["user_id"], name: "index_flags_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_memories", id: false, force: :cascade do |t|
    t.integer "group_id",  null: false
    t.integer "memory_id", null: false
  end

  create_table "groups_occasions", id: false, force: :cascade do |t|
    t.integer "group_id",    null: false
    t.integer "occasion_id", null: false
  end

  create_table "groups_people", id: false, force: :cascade do |t|
    t.integer "group_id",  null: false
    t.integer "person_id", null: false
  end

  create_table "groups_pets", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "pet_id",   null: false
  end

  create_table "groups_places", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "place_id", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image"
    t.integer  "ranking",    default: 0
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "images_people", force: :cascade do |t|
    t.integer  "image_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "title"
    t.text     "address"
    t.integer  "user_id"
    t.integer  "linktype_id"
    t.integer  "flagcount",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "links_people", force: :cascade do |t|
    t.integer  "link_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linktypes", force: :cascade do |t|
    t.string   "linktype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memories", force: :cascade do |t|
    t.string   "title"
    t.text     "story"
    t.integer  "ranking",      default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "flagcount",    default: 0
    t.string   "memory_image"
  end

  create_table "memories_occasions", id: false, force: :cascade do |t|
    t.integer "memory_id",   null: false
    t.integer "occasion_id", null: false
  end

  create_table "memories_people", id: false, force: :cascade do |t|
    t.integer "memory_id", null: false
    t.integer "person_id", null: false
  end

  create_table "memories_pets", id: false, force: :cascade do |t|
    t.integer "memory_id", null: false
    t.integer "pet_id",    null: false
  end

  create_table "memories_places", id: false, force: :cascade do |t|
    t.integer "memory_id", null: false
    t.integer "place_id",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "reciever_id"
    t.text     "message"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "read",        default: false
    t.string   "title"
  end

  create_table "occasions", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.time     "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "middlenames"
    t.string   "lastname"
    t.date     "dob"
    t.date     "died"
    t.integer  "charity_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "place_of_birth"
    t.string   "died_of"
    t.string   "brief_description"
  end

  create_table "people_adminstrations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "adminstrator_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.date     "dob"
    t.date     "died"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "species_id"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.integer  "placetype_id"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "address"
  end

  create_table "placetypes", force: :cascade do |t|
    t.string   "placetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "username",                                null: false
    t.string   "role",                   default: "user"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "memory_id"
    t.integer  "image_id"
    t.integer  "value",           default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "voted_item_id"
    t.string   "voted_item_type"
  end

  add_foreign_key "flags", "memories"
  add_foreign_key "flags", "users"
  add_foreign_key "images", "users"
end
