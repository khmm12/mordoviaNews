class AddNewsCommentBelongsToNews < ActiveRecord::Migration
  def change
      add_belongs_to :news_comments, :news
      add_index :news_comments, :news_id
  end
end
