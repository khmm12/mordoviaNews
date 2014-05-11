class AddCategoryToNews < ActiveRecord::Migration
  def change
      add_column :news, :news_category_id, :integer
      add_index :news, :news_category_id
  end
end
