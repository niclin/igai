class AddCategoryGroupIdToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :category_group_id, :integer
  end
end
