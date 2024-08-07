# app/controllers/uploads_controller.rb
class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show edit destroy]
  skip_before_action :require_admin, only: %i[create set_primary set_menu]

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
    files = Array(params[:images]).reject(&:blank?)

    if files.present?
      uploader = S3Uploader.new(s3_bucket_name, s3_region)
      uploaded_files = []

      files.each do |file|
        original_key = generate_unique_key(file.original_filename)

        if uploader.upload(file.tempfile.path, original_key)
          uploaded_files << {
            filename: file.original_filename,
            content_type: file.content_type,
            file_size: file.size,
            key: original_key,
            uploadable_type: params[:uploadable_type],
            uploadable_id: params[:uploadable_id]
          }
        else
          @upload.errors.add(:base, "Failed to upload file #{file.original_filename} to S3")
        end
      end

      if @upload.errors.empty?
        Upload.transaction do
          uploaded_files.each do |file_data|
            upload = Upload.create!(file_data)
            ImageOptimizerWorker.perform_async(upload.id)
          end
        end

        redirect_back(fallback_location: artists_path, notice: 'Upload was successfully created.')
      else
        cleanup_failed_uploads(uploader, uploaded_files)
        render :new
      end
    else
      @upload.errors.add(:images, 'must be selected')
      render :new
    end
  rescue ActiveRecord::RecordInvalid => e
    cleanup_failed_uploads(uploader, uploaded_files)
    @upload.errors.add(:base, "Failed to save file: #{e.message}")
    render :new
  end

  # specific update action
  def set_primary
    @upload = Upload.find(params[:id])
    @upload.set_as_primary
    redirect_back(fallback_location: artists_path)
  end

  def set_menu
    @upload = Upload.find(params[:id])
    @upload.set_as_menu
    redirect_back(fallback_location: artists_path)
  end

  # DELETE /uploads/1
  def destroy
    uploader = S3Uploader.new(s3_bucket_name, s3_region)
    uploader.delete_file(@upload.key)
    @upload.destroy
    redirect_back(fallback_location: artists_path, notice: 'Upload was successfully destroyed.')
  end

  private

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def generate_unique_key(filename)
    "#{SecureRandom.uuid}_#{filename.parameterize}"
  end

  def s3_bucket_name
    Upload::S3_BUCKET
  end

  def s3_region
    Upload::S3_REGION
  end

  def cleanup_failed_uploads(uploader, uploaded_files)
    uploaded_files.each { |file_data| uploader.delete_file(file_data[:key]) }
  end
end
