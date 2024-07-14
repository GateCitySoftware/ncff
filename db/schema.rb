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

ActiveRecord::Schema[7.1].define(version: 2024_07_14_143843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "website"
    t.json "social_media_links"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "website"
    t.json "social_media_links"
    t.string "product_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "stage_id", null: false
    t.uuid "artist_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description"
    t.boolean "is_headline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_performances_on_artist_id"
    t.index ["stage_id"], name: "index_performances_on_stage_id"
  end

  create_table "schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "google_place_id"
    t.string "google_place_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tagged_items", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tagged_items_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tagged_items_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string "filename"
    t.string "content_type"
    t.integer "file_size"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_uploads_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "website"
    t.json "social_media_links"
    t.string "category"
    t.string "cuisine_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "performances", "artists"
  add_foreign_key "performances", "stages"
  add_foreign_key "tagged_items", "tags"
end
