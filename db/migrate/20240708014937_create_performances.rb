class CreatePerformances < ActiveRecord::Migration[7.1]
  def change
    create_table :performances, id: :uuid do |t|
      t.references :stage, null: false, foreign_key: true, type: :uuid
      t.references :artist, null: false, foreign_key: true, type: :uuid
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.boolean :is_headline

      t.timestamps
    end
  end
end
