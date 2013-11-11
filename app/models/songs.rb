class Songs < ActiveRecord::Base
  
  attr_accessible :title, :artist, :album, :tags, :file
  mount_uploader :file, FileUploader
end
