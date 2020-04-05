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

ActiveRecord::Schema.define(version: 2020_04_05_093449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.datetime "published_at"
    t.string "source"
    t.json "target_rates"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "base", default: "", null: false
    t.json "foreign_rates", default: [], null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments_employees", id: false, force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "employee_id", null: false
    t.index ["department_id", "employee_id"], name: "index_departments_employees_on_department_id_and_employee_id"
    t.index ["employee_id", "department_id"], name: "index_departments_employees_on_employee_id_and_department_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.float "yearly_salary"
    t.date "work_start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
