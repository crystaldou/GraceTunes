class Songs < ActiveRecord::Base
  
  attr_accessible :title, :artist, :album, :tags
  
  #auto_index false for now for testing
  searchable :auto_index => false do 
    text :title, :tags
  end
end
