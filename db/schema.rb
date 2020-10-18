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

ActiveRecord::Schema.define(version: 2020_10_18_161232) do

  create_table "ability_foci", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "npc_id", null: false
    t.string "ability"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["npc_id"], name: "index_ability_foci_on_npc_id"
  end

  create_table "collections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "default_label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_collections_on_name", unique: true
  end

  create_table "npcs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "age"
    t.string "attitude"
    t.string "ancestry"
    t.string "gender"
    t.string "origin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "surname"
    t.string "type"
    t.integer "accuracy", default: 0
    t.integer "communication", default: 0
    t.integer "constitution", default: 0
    t.integer "dexterity", default: 0
    t.integer "fighting", default: 0
    t.integer "intelligence", default: 0
    t.integer "perception", default: 0
    t.integer "strength", default: 0
    t.integer "willpower", default: 0
  end

  create_table "templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "label"
    t.string "generator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_templates_on_collection_id"
  end

  add_foreign_key "ability_foci", "npcs"
  add_foreign_key "templates", "collections"
end
