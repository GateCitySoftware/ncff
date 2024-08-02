module Uploadable
  extend ActiveSupport::Concern

  included do
    has_many :uploads, as: :uploadable
  end

  def primary_image
    uploads.find_by(image_type: 'primary')
  end
end
