class DropStageSchedules < ActiveRecord::Migration[7.1]
  def change
    drop_table :stage_schedules
  end
end
