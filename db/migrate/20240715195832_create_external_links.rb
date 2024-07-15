class CreateExternalLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :external_links do |t|
      t.string :url
      t.string :link_type
      t.references :linkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
