# frozen_string_literal: true

class CreateStages < ActiveRecord::Migration[7.1]
  def change
    create_table :stages, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :google_place_id
      t.string :google_place_address

      t.timestamps
    end
  end
end
