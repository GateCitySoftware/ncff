class AddOwnerIdToTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :merchants

    add_column :artists, :owner_id, :uuid
    add_column :vendors, :owner_id, :uuid
  end
end
