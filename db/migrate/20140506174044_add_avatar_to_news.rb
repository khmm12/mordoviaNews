class AddAvatarToNews < ActiveRecord::Migration
  def change
      add_attachment :news, :avatar
  end
end
