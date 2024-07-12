class CreateActivations < ActiveRecord::Migration[7.1]
  def change
    create_table :activations do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :website
      t.json :social_media_links

      t.timestamps
    end
  end
end
