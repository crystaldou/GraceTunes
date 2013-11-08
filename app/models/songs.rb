class Songs < ActiveRecord::Base
  
  attr_accessible :title, :artist, :album, :tags, :file, :original_filename
  mount_uploader :file, FileUploader
end
