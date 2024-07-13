json.extract! tagged_item, :id, :tag_id, :taggable_id, :taggable_type, :created_at, :updated_at
json.url tagged_item_url(tagged_item, format: :json)
