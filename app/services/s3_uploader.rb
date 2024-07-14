require 'aws-sdk-s3'

class S3Uploader
  def initialize(bucket_name, region = 'us-east-1')
    @bucket_name = bucket_name
    @region = region
    @s3 = Aws::S3::Resource.new(region: @region)
    @bucket = @s3.bucket(@bucket_name)
  end

  def upload(file_path, key = nil)
    file_name = File.basename(file_path)
    key ||= file_name

    begin
      obj = @bucket.object(key)
      obj.upload_file(file_path)
      true
    rescue Aws::S3::Errors::ServiceError => e
      puts "Error uploading file: #{e.message}"
      false
    end
  end

  def upload_from_string(file_content, key)
    obj = @bucket.object(key)
    obj.put(body: file_content)
    true
  rescue Aws::S3::Errors::ServiceError => e
    puts "Error uploading file content: #{e.message}"
    false
  end

  def list_files
    @bucket.objects.map(&:key)
  end

  def file_exists?(key)
    @bucket.object(key).exists?
  end

  def delete_file(key)
    @bucket.object(key).delete
    true
  rescue Aws::S3::Errors::ServiceError => e
    puts "Error deleting file: #{e.message}"
    false
  end
end
