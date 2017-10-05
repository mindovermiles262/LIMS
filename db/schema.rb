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

ActiveRecord::Schema.define(version: 20170930161306) do

  create_table "batches", force: :cascade do |t|
    t.integer "test_method_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_batches_on_test_id"
    t.index ["test_method_id"], name: "index_batches_on_test_method_id"
  end

  create_table "batches_pipets", id: false, force: :cascade do |t|
    t.integer "batch_id"
    t.integer "pipet_id"
  end

  create_table "pipets", force: :cascade do |t|
    t.datetime "calibration_date"
    t.datetime "calibration_due"
    t.integer "min_volume"
    t.integer "max_volume"
    t.boolean "adjustable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.boolean "received", default: false
    t.boolean "completed", default: false
    t.boolean "reported", default: false
    t.boolean "invoiced", default: false
    t.boolean "paid", default: false
    t.integer "user_id"
    t.integer "samples_id"
    t.string "description", default: ""
    t.string "lot", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["samples_id"], name: "index_projects_on_samples_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "samples", force: :cascade do |t|
    t.string "description"
    t.integer "project_id"
    t.integer "tests_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_samples_on_project_id"
    t.index ["tests_id"], name: "index_samples_on_tests_id"
  end

  create_table "test_methods", force: :cascade do |t|
    t.string "name"
    t.string "target_organism"
    t.string "reference_method"
    t.integer "turn_around_time"
    t.integer "detection_limit"
    t.integer "batch_id"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.integer "result"
    t.boolean "PA", default: false
    t.integer "test_method_id"
    t.integer "sample_id"
    t.integer "user_id"
    t.integer "analysts_id"
    t.integer "batch_id"
    t.string "description"
    t.boolean "batched", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysts_id"], name: "index_tests_on_analysts_id"
    t.index ["batch_id"], name: "index_tests_on_batch_id"
    t.index ["sample_id"], name: "index_tests_on_sample_id"
    t.index ["test_method_id"], name: "index_tests_on_test_method_id"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "company", default: ""
    t.string "email", default: "", null: false
    t.boolean "admin", default: false
    t.boolean "analyst", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
