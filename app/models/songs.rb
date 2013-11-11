class Songs < ActiveRecord::Base
  
  #auto_index false for now for testing
  searchable :auto_index => false do 
    text :title, :tags
  end
  attr_accessible :title, :artist, :album, :tags, :file
  mount_uploader :file, FileUploader
end
