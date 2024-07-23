class AddArchivedToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :archived, :boolean, default: false, null: false
  end
end
