# frozen_string_literal: true

json.extract! performance, :id, :stage_id, :artist_id, :start_time, :end_time, :description, :is_headline, :created_at,
              :updated_at
json.url performance_url(performance, format: :json)
