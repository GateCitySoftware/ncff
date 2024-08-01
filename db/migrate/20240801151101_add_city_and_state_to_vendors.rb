class AddCityAndStateToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :city, :string
    add_column :vendors, :state, :string
  end
end
