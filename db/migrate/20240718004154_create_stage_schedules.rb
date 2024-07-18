class CreateStageSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :stage_schedules, id: :uuid do |t|
      t.string :name
      t.date :date
      t.references :stage, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
