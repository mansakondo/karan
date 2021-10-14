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

ActiveRecord::Schema.define(version: 2021_10_14_160657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catalog_marc_record_authority_records", force: :cascade do |t|
    t.string "entity_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalog_marc_record_bibliographic_records", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalog_marc_record_links", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "parent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_catalog_marc_record_links_on_child_id"
    t.index ["parent_id"], name: "index_catalog_marc_record_links_on_parent_id"
  end

  create_table "catalog_marc_records", force: :cascade do |t|
    t.string "leader"
    t.jsonb "fields"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "format", default: 0, null: false
    t.string "marc_recordable_type", null: false
    t.bigint "marc_recordable_id", null: false
    t.index ["marc_recordable_type", "marc_recordable_id"], name: "index_catalog_marc_records_on_marc_recordable"
  end

  add_foreign_key "catalog_marc_record_links", "catalog_marc_records", column: "child_id"
  add_foreign_key "catalog_marc_record_links", "catalog_marc_records", column: "parent_id"
end
