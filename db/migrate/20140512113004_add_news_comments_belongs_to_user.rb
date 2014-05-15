class AddNewsCommentsBelongsToUser < ActiveRecord::Migration
  def change
      add_belongs_to :news_comments, :user
      add_index :news_comments, :user_id
  end
end
