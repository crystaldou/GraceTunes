class AddFileToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :file, :string
  end
end
