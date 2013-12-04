class Songs < ActiveRecord::Base
  
  #auto_index false for now for testing
  # searchable :auto_index => false do 
  #     text :title, :tags
  #   end
  has_and_belongs_to_many :playlists
  include PgSearch
  pg_search_scope :search_lyrics,
    :against => :lyrics,
    :using => {
      :tsearch => {:dictionary => "english", :any_word => "true"}
    }
  attr_accessible :title, :artist, :album, :tags, :file, :lyrics
  mount_uploader :file, FileUploader
  
  def self.searchText(type, text)
    if type == "Title"
      return Songs.where("title LIKE '%#{text}%'")
    elsif type == "Artist"
      return Songs.where("artist LIKE '%#{text}%'")
    elsif type == "Album"
      return Songs.where("album LIKE '%#{text}%'")
    elsif type == "Tags"
      return Songs.where("tags LIKE '%#{text.downcase}%'")
    elsif type == "Lyrics"
      if ActiveRecord::Base.connection.instance_values["config"][:adapter] != "sqlite3"
        return Songs.search_lyrics(text.downcase)
      else
        return Songs.where("lyrics LIKE '%#{text.downcase}%'")
      end
    end
  end

end
