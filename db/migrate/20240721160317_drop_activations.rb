class DropActivations < ActiveRecord::Migration[7.1]
  def change
    drop_table :activations
  end
end
