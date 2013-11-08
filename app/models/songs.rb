class Songs < ActiveRecord::Base
  
  attr_accessible :title, :artist, :album, :tags, :file
  
  #auto_index false for now for testing
  searchable :auto_index => false do 
    text :title, :tags
  end
  mount_uploader :file, FileUploader
end
