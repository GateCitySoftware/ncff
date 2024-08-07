class VendorsController < ApplicationController
  before_action :set_vendor, only: %i[show edit update destroy]
  skip_before_action :require_admin, only: %i[show edit update]

  # TODO: consider creating a MatView for performance summary
  # TODO: also, use caching (with or without MatView)
  def index
    unapproved_listings = true if params[:unapproved_listings] && current_user&.admin?
    @data = ::VendorIndex.all(params[:category], params[:option], unapproved_listings)
  end

  # GET /vendors/1 or /vendors/1.json
  def show
    @data = OpenStruct.new(page_name: 'Vendor Preview')
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
    @tags = Tag.cuisines
    @upload = Upload.new
  end

  # POST /vendors or /vendors.json
  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to vendor_url(@vendor), notice: 'Vendor was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vendors/1 or /vendors/1.json
  def update
    if current_user&.admin?
      just_approved = true if params[:vendor][:approved] == 'true' && @vendor.update(approved: true)
      just_unapproved = true if params[:vendor][:approved] == 'false' && @vendor.update(approved: false)
      just_archived = true if params[:vendor][:archived] == 'true' && @vendor.update(archived: true)
    end

    if just_approved
      redirect_to vendors_url(unapproved_listings: true), notice: 'Listing was successfully approved.'
    elsif just_unapproved
      redirect_to vendors_url(unapproved_listings: true), notice: 'Listing was successfully unapproved.'
    elsif just_archived
      redirect_to vendors_url(unapproved_listings: true), notice: 'Vendor was successfully archived.'
    else
      service = SaveVendor.new(@vendor, params[:vendor]).call
      if service.success?
        redirect_to edit_vendor_url(@vendor), notice: 'Vendor was successfully updated.'
      else
        flash[:error] = "Updates were not saved: #{@vendor.errors.full_messages}"
        redirect_to edit_vendor_url(@vendor)
      end
    end
  end

  # DELETE /vendors/1 or /vendors/1.json
  def destroy
    @vendor.destroy!

    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vendor
    @vendor = Vendor.unscoped.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vendor_params
    params.require(:vendor).permit(:name, :description, :image, :website, :social_media_links, :category, :email,
                                   :phone, :address)
  end
end
