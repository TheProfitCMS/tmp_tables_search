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

ActiveRecord::Schema.define(version: 20151112160210) do

  create_table "brands", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.string   "state",      default: "draft"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_category_relations", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "product_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "product_category_relations", ["product_category_id"], name: "index_product_category_relations_on_product_category_id"
  add_index "product_category_relations", ["product_id"], name: "index_product_category_relations_on_product_id"

  create_table "product_params0_sets", force: :cascade do |t|
    t.string   "title",       default: "USB Flash Drive params"
    t.integer  "size_x",      default: 0
    t.integer  "size_y",      default: 0
    t.integer  "size_z",      default: 0
    t.integer  "volume",      default: 512
    t.string   "volume_text", default: "512 Megabytes"
    t.string   "interface_1", default: "USB 2.0"
    t.string   "interface_2", default: "USB 3.0"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "product_params1_sets", force: :cascade do |t|
    t.string   "title",                                  default: "Notebooks params"
    t.string   "processor_type",                         default: ""
    t.decimal  "display_size",   precision: 8, scale: 2
    t.decimal  "weight",         precision: 8, scale: 2
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",                   precision: 8, scale: 2
    t.integer  "amount",                                          default: 0
    t.string   "state",                                           default: "draft"
    t.integer  "product_params_set_id"
    t.string   "product_params_set_type"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  create_table "products_brands_rels", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
