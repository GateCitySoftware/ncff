class ArtistIndex
  DATA = Struct.new(:artists, :filter_name)

  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
    DATA.new(artists.order(:name), filter_name)
  end

  private

  def artists
    case @category
    when 'genre'
      Artist.by_genre(@option)
    when 'stage'
      Artist.by_stage(@option)
    when 'date'
      Artist.by_date(@option)
    else
      Artist.all
    end
  end

  def filter_name
    if @category == 'date'
      Date.parse(@option).strftime('%A, %B %-d, %Y')
    else
      @option || 'All'
    end
  end
end
