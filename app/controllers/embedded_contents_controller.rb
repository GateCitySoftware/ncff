class EmbeddedContentsController < ApplicationController
  before_action :set_embedded_content, only: %i[show edit update destroy]

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
    @embedded_content = EmbeddedContent.new(params.to_unsafe_h.slice(*EmbeddedContent.new.attributes.keys))
    if @embedded_content.save
      redirect_back(fallback_location: artists_path, notice: 'Embedded content was successfully created.')
    else
      flash[:error] = "Embedded content was not saved. Errors: #{@embedded_content.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: artists_path)
    end
  end

  # PATCH/PUT /embedded_contents/1 or /embedded_contents/1.json
  def update
    respond_to do |format|
      if @embedded_content.update(embedded_content_params)
        format.html do
          redirect_to embedded_content_url(@embedded_content), notice: 'Embedded content was successfully updated.'
        end
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
      format.html do
        redirect_back(fallback_location: artists_path, notice: 'Embedded content was successfully destroyed.')
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_embedded_content
    @embedded_content = EmbeddedContent.find(params[:id])
  end
end
