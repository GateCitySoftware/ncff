class ArtistFilter
  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
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
end
