# frozen_string_literal: true

json.extract! stage, :id, :name, :description, :google_place_id, :google_place_address, :created_at, :updated_at
json.url stage_url(stage, format: :json)
