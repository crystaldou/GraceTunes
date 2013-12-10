class AddFavoritesPlaylistIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorites_playlist_id, :integer
  end
end
