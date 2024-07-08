# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules, id: :uuid do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
