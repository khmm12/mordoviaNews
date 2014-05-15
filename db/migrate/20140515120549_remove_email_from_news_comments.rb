class RemoveEmailFromNewsComments < ActiveRecord::Migration
  def change
    remove_column :news_comments, :email
  end
end
