class AddHideArtistTileToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :hide_tile, :boolean, default: false
  end
end
