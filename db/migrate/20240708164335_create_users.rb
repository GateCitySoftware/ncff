# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :login_token
      t.datetime :login_token_valid_until

      t.timestamps
    end
  end
end
