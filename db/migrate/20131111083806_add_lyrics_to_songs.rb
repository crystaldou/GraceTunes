class AddLyricsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :lyrics, :string
  end
end
