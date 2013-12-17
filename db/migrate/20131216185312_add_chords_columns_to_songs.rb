class AddChordsColumnsToSongs < ActiveRecord::Migration
  def self.up
    add_attachment :songs, :chords
  end

  def self.down
    remove_attachment :songs, :chords
  end
end
