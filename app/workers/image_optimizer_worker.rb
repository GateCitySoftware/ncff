class ImageOptimizerWorker
  include Sidekiq::Worker

  def perform(upload_id)
    upload = Upload.find(upload_id)
    s3_uploader = S3Uploader.new(Upload::S3_BUCKET, Upload::S3_REGION)
    original_file = download_from_s3(s3_uploader, upload.key)

    %w[small medium large].each do |size|
      optimized_file = optimize_image(original_file, size)
      s3_key = upload_to_s3(s3_uploader, optimized_file, size, upload.filename)
      upload.update("#{size}_key": s3_key)
    end
  end

  private

  def download_from_s3(s3_uploader, key)
    tempfile = Tempfile.new(['original', File.extname(key)])
    tempfile.binmode

    s3_uploader.instance_variable_get(:@bucket).object(key).get do |chunk|
      tempfile.write(chunk)
    end

    tempfile.rewind
    tempfile
  end

  def optimize_image(file, size)
    image = MiniMagick::Image.new(file.path)

    case size
    when 'small'
      image.resize '300x300'
    when 'medium'
      image.resize '600x600'
    when 'large'
      image.resize '1200x1200'
    end

    image.strip
    image.quality '85'
    image.format 'webp'

    image
  end

  def upload_to_s3(s3_uploader, file, size, original_filename)
    new_filename = "#{size}_#{File.basename(original_filename, '.*')}.webp"
    key = "optimized/#{new_filename}"

    s3_uploader.upload(file.path, key)
    key
  end
end
