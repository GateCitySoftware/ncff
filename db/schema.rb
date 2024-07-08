# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_708_164_335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'artists', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.text 'bio'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'performances', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'stage_id', null: false
    t.uuid 'artist_id', null: false
    t.datetime 'start_time'
    t.datetime 'end_time'
    t.text 'description'
    t.boolean 'is_headline'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['artist_id'], name: 'index_performances_on_artist_id'
    t.index ['stage_id'], name: 'index_performances_on_stage_id'
  end

  create_table 'schedules', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.date 'date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'stages', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'google_place_id'
    t.string 'google_place_address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'login_token'
    t.datetime 'login_token_valid_until'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'performances', 'artists'
  add_foreign_key 'performances', 'stages'
end
