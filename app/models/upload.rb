# == Schema Information
#
# Table name: uploads
#
#  id              :bigint           not null, primary key
#  filename        :string
#  content_type    :string
#  file_size       :integer
#  key             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image_type      :string           default("gallery"), not null
#  uploadable_type :string
#  uploadable_id   :bigint
#
class Upload < ApplicationRecord
  belongs_to :uploadable, polymorphic: true

  validates :filename, presence: true
  validates :content_type, presence: true
  validates :file_size, presence: true, numericality: { greater_than: 0 }
  validates :key, presence: true, uniqueness: true
  validates :image_type, presence: true, inclusion: { in: %w[primary gallery] }
  validate :only_one_primary_image_per_uploadable

  def s3_url
    "https://#{s3_bucket_name}.s3.#{s3_region}.amazonaws.com/#{key}"
  end

  def set_as_primary
    Upload.transaction do
      # Set all other uploads for this uploadable to "gallery"
      uploadable.uploads.where.not(id:).update_all(image_type: 'gallery')

      # Set this upload to "primary"
      update!(image_type: 'primary')
    end
  end

  private

  def s3_bucket_name
    Rails.application.credentials.aws[:bucket_name]
  end

  def s3_region
    Rails.application.credentials.aws[:region]
  end

  def only_one_primary_image_per_uploadable
    return unless image_type == 'primary' && uploadable.uploads.where(image_type: 'primary').where.not(id:).exists?

    errors.add(:image_type, 'can only have one primary image per uploadable')
  end
end
