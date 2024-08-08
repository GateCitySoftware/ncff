class DropIndexOnSlugFromVendors < ActiveRecord::Migration[7.1]
  def change
    remove_index :vendors, :slug
  end
end
