class DropCuisineTypeFromVendors < ActiveRecord::Migration[7.1]
  def change
    remove_column :vendors, :cuisine_type, :string
  end
end
