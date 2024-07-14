class AddImageTypeToUploads < ActiveRecord::Migration[7.1]
  def change
    add_column :uploads, :image_type, :string, default: 'gallery', null: false
  end
end
