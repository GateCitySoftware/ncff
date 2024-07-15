json.extract! external_link, :id, :url, :link_type, :linkable_id, :linkable_type, :created_at, :updated_at
json.url external_link_url(external_link, format: :json)
