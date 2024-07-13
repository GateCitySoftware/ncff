class CreateTaggedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :tagged_items do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :taggable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
