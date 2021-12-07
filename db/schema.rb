ActiveRecord::Schema.define(version: 2021_12_07_014221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "deadline", default: -> { "CURRENT_DATE" }, null: false
  end

end
