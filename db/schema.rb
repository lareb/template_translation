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

ActiveRecord::Schema.define(version: 2019_07_24_062338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "templates", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.string "description", limit: 400
    t.text "full_content"
    t.text "body"
    t.text "template_with_key"
    t.json "key_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translation_texts", force: :cascade do |t|
    t.integer "template_id", null: false
    t.integer "local"
    t.json "key_value"
    t.text "template_body"
    t.boolean "is_core", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
