class AddEmailPhoneAddressToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :phone, :string
    add_column :vendors, :email, :string
    add_column :vendors, :address, :text
  end
end
