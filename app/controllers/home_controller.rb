class HomeController < ApplicationController
  layout 'around_theme'
  skip_before_action :require_admin, only: %i[landing_page]

  def landing_page
    if params[:welcome] == 'true'
      first_favorite = Favorite.find_by(id: params['id'])
      session[:user_id] = first_favorite.user_id if first_favorite.created_at.after?(1.minute.ago)
      flash.now[:notice] = 'Welcome to the site! You have been logged in.'
    end

    @data = { stats:, artists:, headliner_artists:, stages:, schedule_days:, artists_data: }
  end

  def list_view
  end

  def item_view
  end

  def todo
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
    [
      { value: Artist.count, label: 'Artists' },
      { value: Stage.count, label: 'Stages' },
      { value: 3, label: 'Days' }
    ].sort_by { |stat| stat[:value] }.reverse
  end

  def artists
    all_artists.reject { |artist| artist[:headliner] }.shuffle
  end

  def headliner_artists
    all_artists.select { |artist| artist[:headliner] }.shuffle
  end

  def all_artists
    @all_artists ||= Artist.all.filter_map do |artist|
      next if artist.hide_tile?

      {
        id: artist.id,
        name: artist.name,
        genres: artist.genres,
        image: artist.primary_image(size: 'medium'),
        slug: artist.slug,
        headliner: artist.headliner?
      }
    end
  end

  def artists_data
    ArtistIndex.json_for_react_component
  end
end
