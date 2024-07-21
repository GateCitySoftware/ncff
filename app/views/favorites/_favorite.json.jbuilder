json.extract! favorite, :id, :user_id, :item_id, :item_type, :created_at, :updated_at
json.url favorite_url(favorite, format: :json)
