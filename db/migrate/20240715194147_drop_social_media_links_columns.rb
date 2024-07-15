class DropSocialMediaLinksColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :activations, :social_media_links
    remove_column :merchants, :social_media_links
    remove_column :vendors, :social_media_links
  end
end
