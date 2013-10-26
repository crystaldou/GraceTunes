class Songs < ActiveRecord::Base
  
  attr_accessible :title, :artist, :album, :tags
end
