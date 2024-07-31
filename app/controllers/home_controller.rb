class HomeController < ApplicationController
  layout false, only: %i[index_v3 list_view item_view]

  def landing_page
    @data = {
      stats:,
      artists:,
      headliner_artists:,
      stages:,
      schedule_days:
    }

    render 'home/landing_page/base'
  end

  def list_view
  end

  def item_view
  end

  def gcs_landing_page
  end

  def landing_conference_example
  end

  private

  def stage_schedules
    @stage_schedules ||= StageSchedules.generate
  end

  def stages
    stage_schedules[:stages]
  end

  def schedule_days
    stage_schedules[:schedule_days]
  end

  def stats
    Rails.cache.fetch('festival_statistics', expires_in: 1.minute) do
      [
        { value: Artist.count, label: 'Artists' },
        { value: Stage.count, label: 'Stages' },
        { value: Tag.genre_map.count, label: 'Genres' }
      ].sort_by { |stat| stat[:value] }.reverse
    end
  end

  def artists
    all_artists.reject { |artist| artist[:headliner] }.shuffle
  end

  def headliner_artists
    all_artists.select { |artist| artist[:headliner] }.shuffle
  end

  def all_artists
    @all_artists ||= Artist.all.map do |artist|
      {
        name: artist.name,
        genres: artist.genres,
        image: artist.primary_image(size: 'medium'),
        slug: artist.slug,
        headliner: artist.headliner?
      }
    end
  end
end
