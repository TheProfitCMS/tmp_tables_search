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

ActiveRecord::Schema.define(version: 20151115091901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_index "product_category_relations", ["product_category_id"], name: "index_product_category_relations_on_product_category_id", using: :btree
  add_index "product_category_relations", ["product_id"], name: "index_product_category_relations_on_product_id", using: :btree

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

  create_table "products_searches", force: :cascade do |t|
    t.integer  "p_id"
    t.string   "p_title"
    t.decimal  "p_price",                   precision: 8, scale: 2
    t.integer  "p_amount",                                          default: 0
    t.string   "p_state"
    t.integer  "p_product_params_set_id"
    t.string   "p_product_params_set_type"
    t.datetime "p_created_at",                                                  null: false
    t.datetime "p_updated_at",                                                  null: false
    t.integer  "pb_product_id"
    t.integer  "pb_brand_id"
    t.integer  "pc_product_id"
    t.integer  "pc_product_category_id"
    t.integer  "pp0_size_x"
    t.integer  "pp0_size_y"
    t.integer  "pp0_size_z"
    t.integer  "pp0_volume"
    t.string   "pp0_interface_1"
    t.string   "pp0_interface_2"
    t.string   "pp1_processor_type"
    t.decimal  "pp1_display_size",          precision: 8, scale: 2
    t.decimal  "pp1_weight",                precision: 8, scale: 2
  end

end
