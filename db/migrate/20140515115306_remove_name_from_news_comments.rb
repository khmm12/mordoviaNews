class RemoveNameFromNewsComments < ActiveRecord::Migration
  def change
    remove_column :news_comments, :name
  end
end
