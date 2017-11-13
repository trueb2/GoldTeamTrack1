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

ActiveRecord::Schema.define(version: 20171112034301) do

  create_table "chemicals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "compound_id"
    t.boolean "clear_air_act_chemical"
    t.boolean "is_metal"
    t.string "metal_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "country"
    t.string "state"
    t.integer "zip"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.boolean "federally_owned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_facilities_on_company_id"
  end

  create_table "releases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "year"
    t.float "quantity", limit: 24
    t.string "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chemical_id"
    t.bigint "facility_id"
    t.index ["chemical_id"], name: "index_releases_on_chemical_id"
    t.index ["facility_id"], name: "index_releases_on_facility_id"
  end

  add_foreign_key "facilities", "companies"
  add_foreign_key "releases", "chemicals"
  add_foreign_key "releases", "facilities"
end
