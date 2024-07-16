class UpdatePolymorphicAssociationsToUseUuid < ActiveRecord::Migration[7.1]
  def change
    # Update ExternalLinks
    remove_index :external_links, name: 'index_external_links_on_linkable'
    remove_column :external_links, :linkable_id
    add_column :external_links, :linkable_id, :uuid
    add_index :external_links, %i[linkable_type linkable_id], name: 'index_external_links_on_linkable'

    # Update Uploads
    remove_index :uploads, name: 'index_uploads_on_uploadable'
    remove_column :uploads, :uploadable_id
    add_column :uploads, :uploadable_id, :uuid
    add_index :uploads, %i[uploadable_type uploadable_id], name: 'index_uploads_on_uploadable'

    # Update TaggedItems
    remove_index :tagged_items, name: 'index_tagged_items_on_taggable'
    remove_column :tagged_items, :taggable_id
    add_column :tagged_items, :taggable_id, :uuid
    add_index :tagged_items, %i[taggable_type taggable_id], name: 'index_tagged_items_on_taggable'
  end
end
