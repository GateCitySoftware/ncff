json.extract! upload, :id, :filename, :content_type, :file_size, :key, :created_at, :updated_at
json.url upload_url(upload, format: :json)
