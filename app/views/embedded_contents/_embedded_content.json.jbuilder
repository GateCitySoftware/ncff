json.extract! embedded_content, :id, :url, :content_type, :title, :embed_code, :description, :embeddable_id, :embeddable_type, :created_at, :updated_at
json.url embedded_content_url(embedded_content, format: :json)
