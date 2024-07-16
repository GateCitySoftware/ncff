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

  # POST /uploads for handling upload of multiple images
  def create
    @upload = Upload.new
    files = params[:images].reject(&:blank?) # not sure why its sending a blank string but this fixes it

    if files && !files.empty?
      uploader = S3Uploader.new(s3_bucket_name, s3_region)
      uploaded_files = []

      files.each do |file|
        s3_key = generate_unique_key(file.original_filename)

        if uploader.upload(file.tempfile.path, s3_key)
          uploaded_files << {
            filename: file.original_filename,
            content_type: file.content_type,
            file_size: file.size,
            key: s3_key
          }
        else
          @upload.errors.add(:base, "Failed to upload file #{file.original_filename} to S3")
        end
      end

      if @upload.errors.empty?
        uploaded_files.each do |file_data|
          upload = Upload.new(file_data)
          upload.uploadable_type = params[:uploadable_type]
          upload.uploadable_id = params[:uploadable_id]
          unless upload.save
            @upload.errors.add(:base, "Failed to save file #{file_data[:filename]} to database")
            uploader.delete_file(file_data[:key])
          end
        end

        if @upload.errors.empty?
          redirect_to uploads_path, notice: 'Images were successfully uploaded.'
        else
          render :new
        end
      else
        render :new
      end
    else
      @upload.errors.add(:images, 'must be selected')
      render :new
    end
  end

  # specific update action
  def set_primary
    @upload = Upload.find(params[:id])
    @upload.set_as_primary
    redirect_to @upload, notice: 'Upload was set as primary.'
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
