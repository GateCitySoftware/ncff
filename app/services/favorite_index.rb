class FavoriteIndex
  DATA = Struct.new(:page_name, :favorites)
  PAGE_NAME = 'My Favorites'.freeze

  def self.all(user_id)
    new.call(user_id)
  end

  def call(user_id)
    # TODO: actually use USER_ID when email login is working
    DATA.new(PAGE_NAME, favorites)
  end

  def favorites
    Favorite.all
  end
end
