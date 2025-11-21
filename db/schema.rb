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

ActiveRecord::Schema[8.1].define(version: 2025_11_21_044340) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "email_notification_successfully_sent"
    t.datetime "notification_sent_timestamp"
    t.bigint "task_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["task_id"], name: "index_notifications_on_task_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.date "actual_end_date"
    t.string "client"
    t.datetime "created_at", null: false
    t.date "estimated_end_date"
    t.string "project_type"
    t.date "start_date"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "due_date"
    t.bigint "project_id"
    t.string "status", default: "pending"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address"
    t.boolean "email_notifications_enabled"
    t.string "first_name"
    t.boolean "high_priority_notifications_only"
    t.boolean "in_app_notifications_enabled"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "notifications", "tasks"
  add_foreign_key "notifications", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "tasks", "projects"
end
