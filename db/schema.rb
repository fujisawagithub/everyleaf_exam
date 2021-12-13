ActiveRecord::Schema.define(version: 2021_12_13_035115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "deadline", default: -> { "CURRENT_DATE" }, null: false
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["title"], name: "index_tasks_on_title"
  end

end
