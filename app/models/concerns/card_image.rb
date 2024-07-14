module CardImage
  extend ActiveSupport::Concern

  included do
    has_many :uploads, as: :uploadable
    validate :validate_single_card_image
  end

  def card_image_path
    card_image_upload = uploads.find_by(image_type: 'card_image')
    card_image_upload&.file&.url
  end

  private

  def validate_single_card_image
    card_image_count = uploads.where(image_type: 'card_image').count
    return unless card_image_count > 1

    errors.add(:base, 'Only one card image is allowed')
  end
end
