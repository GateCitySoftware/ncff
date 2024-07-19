class AddTaglineToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :tagline, :string
  end
end
