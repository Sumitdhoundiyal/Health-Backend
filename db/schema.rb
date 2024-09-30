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

ActiveRecord::Schema[7.0].define(version: 2024_09_23_043648) do
  create_table "appointments", force: :cascade do |t|
    t.integer "hospital_id", null: false
    t.integer "doctor_id", null: false
    t.datetime "appointment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_information_id", null: false
    t.time "appointment_time"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["hospital_id"], name: "index_appointments_on_hospital_id"
    t.index ["patient_information_id"], name: "index_appointments_on_patient_information_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "specialization", null: false
    t.string "email"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "hospital_name"
    t.string "hospital_address_line1"
    t.string "hospital_address_line2"
    t.string "hospital_address_line3"
    t.integer "contact_number"
    t.string "email"
    t.string "hospital_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pincode"
  end

  create_table "patient_informations", force: :cascade do |t|
    t.string "aadhar_number"
    t.string "patient_name"
    t.string "patient_guardian_name"
    t.string "patient_address"
    t.string "patient_mobile_number"
    t.string "blood_group"
    t.integer "patient_age"
    t.string "patient_gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "hospitals"
  add_foreign_key "appointments", "patient_informations"
end
