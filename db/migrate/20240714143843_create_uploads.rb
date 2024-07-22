class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads, id: :uuid do |t|
      t.string :filename
      t.string :content_type
      t.integer :file_size
      t.string :key

      t.timestamps
    end
    add_index :uploads, :key, unique: true
  end
end
