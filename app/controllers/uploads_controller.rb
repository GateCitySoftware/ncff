# app/controllers/uploads_controller.rb
class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show edit destroy]

  # GET /uploads
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # POST /uploads
  def create
    file = params[:upload][:image]

    if file
      uploader = S3Uploader.new(s3_bucket_name, s3_region)
      s3_key = generate_unique_key(file.original_filename)

      if uploader.upload(file.tempfile.path, s3_key)
        @upload = Upload.new(
          filename: file.original_filename,
          content_type: file.content_type,
          file_size: file.size,
          key: s3_key
        )

        if @upload.save
          redirect_to @upload, notice: 'Image was successfully uploaded.'
        else
          uploader.delete_file(s3_key) # Rollback S3 upload if model save fails
          render :new
        end
      else
        @upload = Upload.new
        @upload.errors.add(:base, 'Failed to upload file to S3')
        render :new
      end
    else
      @upload = Upload.new
      @upload.errors.add(:image, 'must be selected')
      render :new
    end
  end

  # DELETE /uploads/1
  def destroy
    uploader = S3Uploader.new(s3_bucket_name, s3_region)
    uploader.delete_file(@upload.key)
    @upload.destroy
    redirect_to uploads_url, notice: 'Upload was successfully destroyed.'
  end

  private

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def generate_unique_key(filename)
    "#{SecureRandom.uuid}_#{filename.parameterize}"
  end

  def s3_bucket_name
    Rails.application.credentials.aws[:bucket_name]
  end

  def s3_region
    Rails.application.credentials.aws[:region]
  end
end
