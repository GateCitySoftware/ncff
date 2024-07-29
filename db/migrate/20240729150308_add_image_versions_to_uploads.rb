class AddImageVersionsToUploads < ActiveRecord::Migration[7.1]
  def change
    add_column :uploads, :small_key, :string
    add_column :uploads, :medium_key, :string
    add_column :uploads, :large_key, :string
  end
end
