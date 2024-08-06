# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  layout 'around_theme', only: %i[index show]
  skip_before_action :require_admin, only: %i[index show]

  # TODO: consider creating a MatView for performance summary
  # TODO: also, use caching (with or without MatView)
  def index
    @data = ArtistIndex.json_for_react_component
  end

  # GET /artists/1 or /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
    @artist.tagged_items.build if @artist.tagged_items.empty?
    @tags = Tag.genres.order(:name)
    @upload = Upload.new
    @embedded_content = EmbeddedContent.new
  end

  # POST /artists or /artists.json
  def create
    @artist = Artist.new(params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_url(@artist), notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1 or /artists/1.json
  def update
    service = SaveArtist.new(@artist, params[:artist]).call

    if service.success?
      redirect_to @artist, notice: 'Artist was successfully updated.'
    else
      @tags = Tag.all
      render :edit
    end
  end

  # DELETE /artists/1 or /artists/1.json
  def destroy
    @artist.destroy!

    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = if uuid?(params[:id])
                Artist.find(params[:id])
              else
                Artist.find_by_slug!(params[:id])
              end
  end
end
