class ArtistIndex
  DATA = Struct.new(:page_name, :artists, :filter_category, :filter_name, :stage_slug, :genre_map, :stage_map,
                    :date_map)
  PAGE_NAME = 'NC Folk Festival Artists'

  def self.all(category, option)
    new(category, option).call
  end

  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
    DATA.new(PAGE_NAME, artists.order(:name), @category, filter_name, stage_slug, Tag.genre_map, Performance.stage_map,
             Performance.date_map)
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

  def stage_slug
    return unless @category == 'stage'

    Stage.find_by_name(@option).slug
  end
end
