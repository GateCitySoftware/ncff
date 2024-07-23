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

ActiveRecord::Schema[7.1].define(version: 2024_07_23_133912) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "tagline"
    t.uuid "owner_id"
    t.index ["slug"], name: "index_artists_on_slug", unique: true
  end

  create_table "embedded_contents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.string "content_type"
    t.string "title"
    t.text "embed_code"
    t.text "description"
    t.string "embeddable_type", null: false
    t.uuid "embeddable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embeddable_type", "embeddable_id"], name: "index_embedded_contents_on_embeddable"
  end

  create_table "external_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.string "link_type"
    t.string "linkable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "linkable_id"
    t.index ["linkable_type", "linkable_id"], name: "index_external_links_on_linkable"
  end

  create_table "favorites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_favorites_on_item"
    t.index ["user_id"], name: "index_favorites_on_user_id"
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

  create_table "stages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "google_place_id"
    t.string "google_place_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_stages_on_slug", unique: true
  end

  create_table "tagged_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tag_id", null: false
    t.string "taggable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "taggable_id"
    t.index ["tag_id"], name: "index_tagged_items_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tagged_items_on_taggable"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sub_category", null: false
    t.index ["category", "sub_category"], name: "index_tags_on_category_and_sub_category"
  end

  create_table "uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "filename"
    t.string "content_type"
    t.integer "file_size"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_type", default: "gallery", null: false
    t.string "uploadable_type"
    t.uuid "uploadable_id"
    t.index ["key"], name: "index_uploads_on_key", unique: true
    t.index ["uploadable_type", "uploadable_id"], name: "index_uploads_on_uploadable"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "attendee", null: false
  end

  create_table "vendors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "website"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "phone"
    t.string "email"
    t.text "address"
    t.uuid "owner_id"
    t.boolean "approved", default: false, null: false
    t.index ["slug"], name: "index_vendors_on_slug", unique: true
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "performances", "artists"
  add_foreign_key "performances", "stages"
  add_foreign_key "tagged_items", "tags"
end
