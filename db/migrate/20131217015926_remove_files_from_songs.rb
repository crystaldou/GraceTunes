class RemoveFilesFromSongs < ActiveRecord::Migration
  def up
    remove_column :songs, :file
  end

  def down
  end
end
