# == Schema Information
#
# Table name: uploads
#
#  id              :uuid             not null, primary key
#  filename        :string
#  content_type    :string
#  file_size       :integer
#  key             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image_type      :string           default("gallery"), not null
#  uploadable_type :string
#  uploadable_id   :uuid
#  small_key       :string
#  medium_key      :string
#  large_key       :string
#
class Upload < ApplicationRecord
  S3_BUCKET =  Rails.env.production? ? 'gcs-ncff' : 'gcs-ncff-dev'
  S3_REGION =  'us-east-2'
  belongs_to :uploadable, polymorphic: true
  has_paper_trail

  validates :filename, presence: true
  validates :content_type, presence: true
  validates :file_size, presence: true, numericality: { greater_than: 0 }
  validates :key, presence: true, uniqueness: true
  validates :image_type, presence: true, inclusion: { in: %w[primary gallery] }
  validate :only_one_primary_image_per_uploadable

  after_save :set_as_primary, if: -> { image_type != 'primary' && !primary_image_exists? }

  def s3_url(size:)
    selected_key = case size
                   when 'original'
                     key
                   when 'small'
                     small_key
                   when 'medium'
                     medium_key
                   when 'large'
                     large_key
                   else
                     raise ArgumentError, "Invalid size. Must be 'original', 'small', 'medium', or 'large'."
                   end

    "https://#{s3_bucket_name}.s3.#{s3_region}.amazonaws.com/#{selected_key}"
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
    S3_BUCKET
  end

  def s3_region
    S3_REGION
  end

  def only_one_primary_image_per_uploadable
    return unless image_type == 'primary' && primary_image_exists?

    errors.add(:image_type, 'can only have one primary image per uploadable')
  end

  def primary_image_exists?
    uploadable.uploads.where(image_type: 'primary').where.not(id:).exists?
  end
end
