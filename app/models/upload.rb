class Upload < ApplicationRecord
  validates :filename, presence: true
  validates :content_type, presence: true
  validates :file_size, presence: true, numericality: { greater_than: 0 }
  validates :key, presence: true, uniqueness: true

  def s3_url
    "https://#{s3_bucket_name}.s3.#{s3_region}.amazonaws.com/#{key}"
  end

  private

  def s3_bucket_name
    Rails.application.credentials.aws[:bucket_name]
  end

  def s3_region
    Rails.application.credentials.aws[:region]
  end
end
