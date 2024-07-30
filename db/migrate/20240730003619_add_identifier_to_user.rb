class AddIdentifierToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :identifier, :string, null: false, default: ''
    add_index :users, :identifier, unique: true
    change_column_default :users, :identifier, nil
  end
end
