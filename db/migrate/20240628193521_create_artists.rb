class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    drop_table :artists if table_exists?(:artists)

    create_table :artists, id: :uuid do |t|
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
