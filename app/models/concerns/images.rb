module Images
  extend ActiveSupport::Concern

  included do
    has_many :uploads, as: :uploadable
  end

  def primary_image(size: 'small')
    card_image_upload = uploads.find_by(image_type: 'primary') || uploads.first
    card_image_upload&.s3_url(size:) || 'https://via.placeholder.com/300x200'
  end
end
