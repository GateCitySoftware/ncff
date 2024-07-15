class ExternalLinksController < ApplicationController
  before_action :set_external_link, only: %i[ show edit update destroy ]

  # GET /external_links or /external_links.json
  def index
    @external_links = ExternalLink.all
  end

  # GET /external_links/1 or /external_links/1.json
  def show
  end

  # GET /external_links/new
  def new
    @external_link = ExternalLink.new
  end

  # GET /external_links/1/edit
  def edit
  end

  # POST /external_links or /external_links.json
  def create
    @external_link = ExternalLink.new(external_link_params)

    respond_to do |format|
      if @external_link.save
        format.html { redirect_to external_link_url(@external_link), notice: "External link was successfully created." }
        format.json { render :show, status: :created, location: @external_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @external_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_links/1 or /external_links/1.json
  def update
    respond_to do |format|
      if @external_link.update(external_link_params)
        format.html { redirect_to external_link_url(@external_link), notice: "External link was successfully updated." }
        format.json { render :show, status: :ok, location: @external_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @external_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_links/1 or /external_links/1.json
  def destroy
    @external_link.destroy!

    respond_to do |format|
      format.html { redirect_to external_links_url, notice: "External link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_link
      @external_link = ExternalLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def external_link_params
      params.require(:external_link).permit(:url, :link_type, :linkable_id, :linkable_type)
    end
end
