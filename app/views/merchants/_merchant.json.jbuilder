json.extract! merchant, :id, :name, :description, :image, :website, :social_media_links, :product_type, :created_at, :updated_at
json.url merchant_url(merchant, format: :json)
