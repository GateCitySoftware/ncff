class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[show edit update destroy]
  skip_before_action :require_admin

  # GET /favorites or /favorites.json
  def index
    @data = FavoriteIndex.all(current_user.id)
  end

  # GET /favorites/1 or /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites or /favorites.json
  def create
    @favorite = Favorite.new(item_id: params[:item_id], item_type: params[:item_type])

    if current_user.present?
      @favorite.user_id = current_user.id
    elsif params[:email].present?
      user = User.find_or_initialize_by(identifier: params[:email])
      if user.new_record?
        user_created = true
        user.password = SecureRandom.hex(16)
        user.save!
      end
      @favorite.user_id = user.id
      session[:user_id] = user.id
    end

    @favorite.save
    render json: { success: true, uuid: @favorite.id }, status: 201
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to favorite_url(@favorite), notice: 'Favorite was successfully updated.' }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy!

    respond_to do |format|
      format.html { redirect_to favorites_url, notice: 'Favorite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
end
