class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    # NOTE: this is weird having this here but necessary....
    # users was originally created with a bigint id, but we want to use uuids
    # I went back and changed the original migration and re-ran everything locally
    # but I can't do that in the Prod environment because it's already been run
    # and I don't want to drop the DB and lose all the data I have entered...
    drop_table :users
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :login_token
      t.datetime :login_token_valid_until
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :role, default: 'attendee', null: false
    end

    create_table :favorites, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :item, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
