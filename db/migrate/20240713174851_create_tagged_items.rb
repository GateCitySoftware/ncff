class CreateTaggedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :tagged_items, id: :uuid do |t|
      t.references :tag, null: false, foreign_key: true, type: :uuid
      t.references :taggable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
