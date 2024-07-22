class CreateEmbeddedContents < ActiveRecord::Migration[7.1]
  def change
    create_table :embedded_contents, id: :uuid do |t|
      t.string :url
      t.string :content_type
      t.string :title
      t.text :embed_code
      t.text :description
      t.references :embeddable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
