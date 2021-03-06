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

ActiveRecord::Schema.define(version: 2021_01_18_045355) do

  create_table "exhibit_favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "exhibit_id", null: false
    t.bigint "tourist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_id"], name: "index_exhibit_favorites_on_exhibit_id"
    t.index ["tourist_id"], name: "index_exhibit_favorites_on_tourist_id"
  end

  create_table "exhibits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exhibits_on_user_id"
  end

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tourist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tourist_id"], name: "index_favorites_on_tourist_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
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
    t.decimal "latitude", precision: 12, scale: 8
    t.decimal "longitude", precision: 12, scale: 8
    t.string "telephone", default: ""
    t.text "company_site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail"
    t.index ["major_category"], name: "index_profiles_on_major_category"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tourist_id", null: false
    t.string "lang", null: false
    t.text "post_review", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tourist_id"], name: "index_reviews_on_tourist_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tourists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.string "thumbnail"
    t.integer "sex", default: 0, null: false
    t.integer "birth", default: 0, null: false
    t.string "country", default: "na", null: false
    t.string "lang", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_tourists_on_email", unique: true
  end

  create_table "user_statistics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tourist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tourist_id"], name: "index_user_statistics_on_tourist_id"
    t.index ["user_id"], name: "index_user_statistics_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "exhibit_favorites", "exhibits"
  add_foreign_key "exhibit_favorites", "tourists"
  add_foreign_key "exhibits", "users"
  add_foreign_key "favorites", "tourists"
  add_foreign_key "favorites", "users"
  add_foreign_key "multi_exhibits", "exhibits"
  add_foreign_key "multi_profiles", "users"
  add_foreign_key "pictures", "exhibits"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "tourists"
  add_foreign_key "reviews", "users"
  add_foreign_key "user_statistics", "tourists"
  add_foreign_key "user_statistics", "users"
end
