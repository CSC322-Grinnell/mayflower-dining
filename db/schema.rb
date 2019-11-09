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

ActiveRecord::Schema.define(version: 2019_11_15_193127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "dish_type"
  end

  create_table "dishes_menus", force: :cascade do |t|
    t.bigint "dish_id"
    t.bigint "menu_id"
    t.boolean "temp", default: false
    t.boolean "show", default: true
    t.index ["dish_id"], name: "index_dishes_menus_on_dish_id"
    t.index ["menu_id"], name: "index_dishes_menus_on_menu_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "mech_soft"
    t.string "pureed"
    t.string "diet"
    t.integer "hc_prep"
    t.integer "hc_prep_leftover"
    t.integer "bb_prep"
    t.integer "bb_prep_leftover"
    t.integer "buckley_prep"
    t.integer "buckley_prep_leftover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.integer "day"
    t.string "type_of_meal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day", "type_of_meal"], name: "by_day_type_of_meal", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.string "portion_size"
    t.string "ingredients_type"
    t.bigint "dish_id"
    t.bigint "ingredient_id"
    t.integer "step"
    t.index ["dish_id"], name: "index_recipes_on_dish_id"
    t.index ["ingredient_id"], name: "index_recipes_on_ingredient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
