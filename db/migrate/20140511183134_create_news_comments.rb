class CreateNewsComments < ActiveRecord::Migration
  def change
    create_table :news_comments do |t|
      t.string :name
      t.string :content
      t.string :email
      t.string :ip

      t.timestamps
    end
  end
end
