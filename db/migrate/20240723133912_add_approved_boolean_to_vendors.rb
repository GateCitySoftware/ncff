class AddApprovedBooleanToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :approved, :boolean, default: false, null: false
  end
end
