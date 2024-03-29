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

ActiveRecord::Schema[7.0].define(version: 2023_11_07_013452) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "group"
    t.boolean "status"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meal_choice"
    t.boolean "welcome_party"
    t.integer "table"
    t.integer "table_pos", default: 0
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "sites", force: :cascade do |t|
    t.string "site_id"
    t.string "template"
    t.string "body_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
  end

  create_table "sites_roles", id: false, force: :cascade do |t|
    t.bigint "site_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_sites_roles_on_role_id"
    t.index ["site_id", "role_id"], name: "index_sites_roles_on_site_id_and_role_id"
    t.index ["site_id"], name: "index_sites_roles_on_site_id"
  end

end
