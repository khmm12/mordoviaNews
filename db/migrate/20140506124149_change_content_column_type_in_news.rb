class ChangeContentColumnTypeInNews < ActiveRecord::Migration
  def change
      change_column :news, :content, :text
  end
end
