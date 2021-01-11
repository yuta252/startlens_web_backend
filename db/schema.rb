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

ActiveRecord::Schema.define(version: 2021_01_11_100942) do

  create_table "exhibits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exhibits_on_user_id"
  end

  create_table "multi_exhibits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "exhibit_id", null: false
    t.string "lang", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_id"], name: "index_multi_exhibits_on_exhibit_id"
  end

  create_table "multi_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "lang", null: false
    t.string "username", null: false
    t.text "self_intro", null: false
    t.string "address_prefecture"
    t.string "address_city"
    t.string "address_street"
    t.string "entrance_fee"
    t.string "business_hours"
    t.string "holiday"
    t.integer "translated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_prefecture"], name: "index_multi_profiles_on_address_prefecture"
    t.index ["user_id", "lang"], name: "index_multi_profiles_on_user_id_and_lang", unique: true
    t.index ["user_id"], name: "index_multi_profiles_on_user_id"
    t.index ["username"], name: "index_multi_profiles_on_username"
  end

  create_table "pictures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "exhibit_id", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_id"], name: "index_pictures_on_exhibit_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "major_category", default: 0
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "telephone", default: ""
    t.text "company_site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail"
    t.index ["major_category"], name: "index_profiles_on_major_category"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "exhibits", "users"
  add_foreign_key "multi_exhibits", "exhibits"
  add_foreign_key "multi_profiles", "users"
  add_foreign_key "pictures", "exhibits"
  add_foreign_key "profiles", "users"
end
