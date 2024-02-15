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

ActiveRecord::Schema[7.1].define(version: 2024_02_15_084807) do
  create_table "clocks", force: :cascade do |t|
    t.datetime "datetime_now"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distance_from_entries", force: :cascade do |t|
    t.integer "distance"
    t.integer "parking_entry_point_id", null: false
    t.integer "parking_slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_entry_point_id"], name: "index_distance_from_entries_on_parking_entry_point_id"
    t.index ["parking_slot_id"], name: "index_distance_from_entries_on_parking_slot_id"
  end

  create_table "parking_entry_points", force: :cascade do |t|
    t.string "name"
    t.integer "parking_lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["parking_lot_id"], name: "index_parking_entry_points_on_parking_lot_id"
    t.index ["slug"], name: "index_parking_entry_points_on_slug", unique: true
  end

  create_table "parking_lots", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_slips", force: :cascade do |t|
    t.datetime "time_in"
    t.datetime "effective_time_in"
    t.datetime "time_out"
    t.decimal "total_parking_fee"
    t.integer "vehicle_id", null: false
    t.integer "parking_slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id"], name: "index_parking_slips_on_parking_slot_id"
    t.index ["vehicle_id"], name: "index_parking_slips_on_vehicle_id"
  end

  create_table "parking_slots", force: :cascade do |t|
    t.integer "size"
    t.boolean "is_available"
    t.integer "parking_lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_lot_id"], name: "index_parking_slots_on_parking_lot_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate_number"
    t.boolean "is_parked"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plate_number"], name: "index_vehicles_on_plate_number", unique: true
  end

  add_foreign_key "distance_from_entries", "parking_entry_points"
  add_foreign_key "distance_from_entries", "parking_slots"
  add_foreign_key "parking_entry_points", "parking_lots"
  add_foreign_key "parking_slips", "parking_slots"
  add_foreign_key "parking_slips", "vehicles"
  add_foreign_key "parking_slots", "parking_lots"
end
