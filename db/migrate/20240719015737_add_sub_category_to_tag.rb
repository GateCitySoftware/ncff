class AddSubCategoryToTag < ActiveRecord::Migration[7.1]
  def change
    add_column :tags, :sub_category, :string
    Tag.all.update(sub_category: 'none')
    change_column_null :tags, :sub_category, false
    add_index :tags, %i[category sub_category]
  end
end
