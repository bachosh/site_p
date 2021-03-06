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

ActiveRecord::Schema.define(version: 20180414115317) do

  create_table "coparts", force: :cascade do |t|
    t.string "record_status"
    t.string "lot_n"
    t.text "row_hash"
    t.string "lot_img_fld"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filtercoparts", force: :cascade do |t|
    t.string "record_status"
    t.string "vechile_type"
    t.string "year"
    t.string "make"
    t.string "model_group"
    t.string "model_detail"
    t.string "damage_description"
    t.string "lot_cond"
    t.integer "odometer"
    t.string "engine"
    t.string "drive"
    t.string "transmission"
    t.string "fuel_type"
    t.string "runs_drives"
    t.string "location_city"
    t.string "buy_it_now_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "sale_date"
    t.integer "to_year"
    t.integer "to_odometer"
  end

  create_table "filterlinks", force: :cascade do |t|
    t.string "csv_header_name"
    t.string "column_name"
    t.string "comments"
    t.integer "csv_header_numb"
  end

end
