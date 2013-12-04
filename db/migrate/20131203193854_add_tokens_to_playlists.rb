class AddTokensToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :token, :string
    remove_column :playlists, :user_id
    
    create_table :playlists_users do |t|
      t.belongs_to :playlist
      t.belongs_to :user
    end
  end
end
