class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    @playlists = Playlist.all
  end

  def show
    id = params[:id]
    @playlist = Playlist.find(id)
    
    @songs = @playlist.songss
    
    @tags = {}
    @songs.each do |song|
      begin
        @tags[song] = song.tags.split(", ")
      rescue
        @tags[song] = []
      end
    end
  end

end
