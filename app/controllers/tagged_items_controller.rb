class TaggedItemsController < ApplicationController
  before_action :set_tagged_item, only: %i[ show edit update destroy ]

  # GET /tagged_items or /tagged_items.json
  def index
    @tagged_items = TaggedItem.all
  end

  # GET /tagged_items/1 or /tagged_items/1.json
  def show
  end

  # GET /tagged_items/new
  def new
    @tagged_item = TaggedItem.new
  end

  # GET /tagged_items/1/edit
  def edit
  end

  # POST /tagged_items or /tagged_items.json
  def create
    @tagged_item = TaggedItem.new(tagged_item_params)

    respond_to do |format|
      if @tagged_item.save
        format.html { redirect_to tagged_item_url(@tagged_item), notice: "Tagged item was successfully created." }
        format.json { render :show, status: :created, location: @tagged_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tagged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tagged_items/1 or /tagged_items/1.json
  def update
    respond_to do |format|
      if @tagged_item.update(tagged_item_params)
        format.html { redirect_to tagged_item_url(@tagged_item), notice: "Tagged item was successfully updated." }
        format.json { render :show, status: :ok, location: @tagged_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tagged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tagged_items/1 or /tagged_items/1.json
  def destroy
    @tagged_item.destroy!

    respond_to do |format|
      format.html { redirect_to tagged_items_url, notice: "Tagged item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagged_item
      @tagged_item = TaggedItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tagged_item_params
      params.require(:tagged_item).permit(:tag_id, :taggable_id, :taggable_type)
    end
end
