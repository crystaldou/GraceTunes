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
  
  pg_search_scope :search_all,
    :against => [:title, :artist, :lyrics, :tags],
    :using => {
      :tsearch => {:dictionary => "english", :any_word => "true"}
    }
  attr_accessible :title, :artist, :album, :tags, :lyrics, :chords, :chords_file_name
  has_attached_file :chords, 
    :storage => :s3,
    :bucket => 'gracetunes',
    :s3_credentials => {
      :access_key_id => 'AKIAICH24MMQVHPTTXGA',
      :secret_access_key => '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'
    }
  
  
  
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
    elsif type == "All"
      if ActiveRecord::Base.connection.instance_values["config"][:adapter] != "sqlite3"
        return Songs.search_all(text.downcase)
      else
        return Songs.where("title LIKE '%#{text.downcase}%'")
      end
    end
    
  end

end
