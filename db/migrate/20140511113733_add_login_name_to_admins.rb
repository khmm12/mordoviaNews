class AddLoginNameToAdmins < ActiveRecord::Migration
  def change
      add_column :admins, :login_name, :string
      add_index :admins, :login_name
  end
end
