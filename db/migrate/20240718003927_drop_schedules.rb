class DropSchedules < ActiveRecord::Migration[7.1]
  def change
    drop_table :schedules
  end
end
