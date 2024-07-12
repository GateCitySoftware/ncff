class CreateVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :website
      t.json :social_media_links
      t.string :category
      t.string :cuisine_type

      t.timestamps
    end
  end
end
