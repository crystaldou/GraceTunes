class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
    
    create_table :song_playlists do |t|
      t.belongs_to :playlist
      t.belongs_to :song
    end
  
  end
end
