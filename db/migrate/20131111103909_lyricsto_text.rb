class LyricstoText < ActiveRecord::Migration
  def up
      change_column :songs, :lyrics, :text, :limit => nil
  end
  def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :songs, :lyrics, :string
  end
end
