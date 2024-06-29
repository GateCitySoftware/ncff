# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]

  # GET /artists or /artists.json
  def index
    @stages = [
      'Cone Health CityStage',
      'Lawn Stage',
      'Old Courthouse Stage',
      'Van Dyke Stage'
    ]

    @days = %w[Thursday Friday Saturday]
    @times = (1..8).to_a.map { |hour| ["#{hour}:00", "#{hour}:30"] }.flatten

    @music_genres = [
      'Alternative',
      'Blues',
      'Classical',
      'Country',
      'Electronic',
      'Folk',
      'Funk',
      'Hip Hop',
      'Indie',
      'Jazz',
      'Latin',
      'Metal',
      'Pop',
      'Punk',
      'R&B',
      'Reggae',
      'Rock',
      'Soul',
      'World'
    ]

    @dummy_data = [
      ['THE WAR & TREATY', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/3-1024x732.png'],
      ['LOS LONELY BOYS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/1-1024x732.png'],
      ['MIPSO', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/2-1024x732.png'],
      ['RISSI PALMER', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/2-1-1024x683.png'],
      ['THE PSYCODELICS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/1-1-1024x683.png'],
      ['SUSTO', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/Untitled-design-14-1024x683.png'],
      ['JON MUQ', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/7-1024x614.png'],
      ['TAE LEWIS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/18-1024x614.png'],
      ['BIO RITMO', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/8-1024x614.png'],
      ['OLIVE KLUG', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/21-1024x614.png'],
      ['DEMEANOR', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/Untitled-design-11-1024x614.png'],
      ['SAM FRIBUSH ORGAN TRIO featuring Calvin Napper and Charlie Hunter', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/1-2-1024x614.png'],
      ['CANDICE IVORY ENSEMBLE', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/5-1024x614.png'],
      ['ETHNO USA', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/2-2-1024x614.png'],
      ['ELIAS ALEXANDER', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/22-1024x614.png'],
      ['HOLLER CHOIR', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/24-1024x614.png'],
      ['LAKOTA JOHN', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/4-1024x614.png'],
      ['ABBY HAMILTON', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/6-1024x614.png'],
      ['SHE RETURNS FROM WAR', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/12-1024x614.png'],
      ['BLUE RIDGE GIRLS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/16-1024x614.png'],
      ['CAIQUE VIDAL & BATUQUE', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/13-1024x614.png'],
      ['DASHAWN HICKMAN presents SACRED STEEL featuring WENDY HICKMAN', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/10-1024x614.png'],
      ['OLD HEAVY HANDS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/Untitled-design-10-1024x614.png'],
      ['COLIN CUTLER & HOT PEPPER JAM', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/23-1024x614.png'],
      ['DREW FOUST & THE WHEELHOUSE', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/15-1024x614.png'],
      ['OXENTE', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/14-1024x614.png'],
      ['EMANUEL WYNTER', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/Untitled-design-12-1024x614.png'],
      ['WILD ROOTS', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/Untitled-design-13-1024x614.png'],
      ['UNHEARD PROJECT', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/11-1024x614.png'],
      ['ABIGAIL DOWD', 'https://ncfolkfestival.com/wp-content/uploads/2024/06/9-1024x614.png']
    ]
    # @artists = Artist.all
  end

  # GET /artists/1 or /artists/1.json
  def show; end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit; end

  # POST /artists or /artists.json
  def create
    @artist = Artist.new(artist_params)

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
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to artist_url(@artist), notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
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
    @artist = Artist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artist_params
    params.require(:artist).permit(:name, :bio)
  end
end
