class VendorsController < ApplicationController
  before_action :set_vendor, only: %i[show edit update destroy]

  # TODO: consider creating a MatView for performance summary
  # TODO: also, use caching (with or without MatView)
  def index
    # TODO: chaneg this when user login is working!
    user_can_edit = true
    unapproved_listings = true if params[:unapproved_listings] && user_can_edit
    @data = ::VendorIndex.all(params[:category], params[:option], unapproved_listings)
  end

  # GET /vendors/1 or /vendors/1.json
  def show
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
    # TODO: chaneg this when user login is working!
    user_can_edit = true
    just_approved = true if params[:vendor][:approved] == 'true' && user_can_edit && @vendor.update(approved: true)
    just_archived = true if params[:vendor][:archived] == 'true' && user_can_edit && @vendor.update(archived: true)

    if just_approved
      redirect_to vendors_url(unapproved_listings: true), notice: 'Listing was successfully approved.'
    elsif just_archived
      redirect_to vendors_url(unapproved_listings: true), notice: 'Vendor was successfully archived.'
    elsif @vendor.update(vendor_params)
      redirect_to edit_vendor_url(@vendor), notice: 'Vendor was successfully updated.'
    else
      redirect_to edit_vendor_url(@vendor), notice: "Updates were not saved: #{@vendor.errors.full_messages}"
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
