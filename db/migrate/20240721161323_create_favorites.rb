class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, polymorphic: true, null: false

      t.timestamps
    end
  end
end
