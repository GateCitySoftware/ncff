class EmbeddedContentsController < ApplicationController
  before_action :set_embedded_content, only: %i[ show edit update destroy ]

  # GET /embedded_contents or /embedded_contents.json
  def index
    @embedded_contents = EmbeddedContent.all
  end

  # GET /embedded_contents/1 or /embedded_contents/1.json
  def show
  end

  # GET /embedded_contents/new
  def new
    @embedded_content = EmbeddedContent.new
  end

  # GET /embedded_contents/1/edit
  def edit
  end

  # POST /embedded_contents or /embedded_contents.json
  def create
    @embedded_content = EmbeddedContent.new(embedded_content_params)

    respond_to do |format|
      if @embedded_content.save
        format.html { redirect_to embedded_content_url(@embedded_content), notice: "Embedded content was successfully created." }
        format.json { render :show, status: :created, location: @embedded_content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @embedded_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /embedded_contents/1 or /embedded_contents/1.json
  def update
    respond_to do |format|
      if @embedded_content.update(embedded_content_params)
        format.html { redirect_to embedded_content_url(@embedded_content), notice: "Embedded content was successfully updated." }
        format.json { render :show, status: :ok, location: @embedded_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @embedded_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /embedded_contents/1 or /embedded_contents/1.json
  def destroy
    @embedded_content.destroy!

    respond_to do |format|
      format.html { redirect_to embedded_contents_url, notice: "Embedded content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embedded_content
      @embedded_content = EmbeddedContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def embedded_content_params
      params.require(:embedded_content).permit(:url, :content_type, :title, :embed_code, :description, :embeddable_id, :embeddable_type)
    end
end
