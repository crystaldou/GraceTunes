class Songs < ActiveRecord::Base
  
  #auto_index false for now for testing
  # searchable :auto_index => false do 
  #     text :title, :tags
  #   end
  include PgSearch
  pg_search_scope :search_lyrics,
    :against => :lyrics,
    :using => {
      :tsearch => {:dictionary => "english", :any_word => "true"}
    }
  attr_accessible :title, :artist, :album, :tags, :file, :lyrics
  mount_uploader :file, FileUploader
end
