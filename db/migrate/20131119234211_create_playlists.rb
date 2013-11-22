class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
    
    create_table :playlists_songs do |t|
      t.belongs_to :playlist
      t.belongs_to :songs
    end
  
  end
end
