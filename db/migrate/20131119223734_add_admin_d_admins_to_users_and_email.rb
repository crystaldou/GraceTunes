class AddAdminDAdminsToUsersAndEmail < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :email, :string
  end
end
