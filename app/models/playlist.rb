class Playlist < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :songss
  has_and_belongs_to_many :users
  before_create :add_token

  def self.searchList(text)
    return Playlist.where("name ILIKE '%#{text}%'")
  end

  def self.createPreview playlists
    @song_preview = {}
    playlists.each do |playlist|
      @song_preview[playlist] = ""
      playlist.songss.each do |song|
        @song_preview[playlist] << song.title << ", "
      end
      @song_preview[playlist] = @song_preview[playlist][0...-2]
      if @song_preview[playlist].length > 150
        @song_preview[playlist] = @song_preview[playlist][0,150]
        if @song_preview[playlist][150] == ','
          @song_preview[playlist] = @song_preview[playlist][0...150]
        end
        @song_preview[playlist] << "..."
      end
    end
    return @song_preview
  end
  
  private
  
  def add_token
    begin
      self.token = SecureRandom.hex[0,10].upcase
    end while self.class.exists?(token: token)
  end


  
end
