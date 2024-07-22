class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
