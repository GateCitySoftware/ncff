class AddHeadlinerToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :headliner, :boolean, default: false, null: false
  end
end
