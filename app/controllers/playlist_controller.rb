class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    if current_user != nil
      @playlists = Playlist.where(:user_id => current_user.uid)
    else
      @playlists = Playlist.all
    end
    @song_preview = {}
    @playlists.each do |playlist|
      @song_preview[playlist] = ""
      playlist.songss.each do |song|
        @song_preview[playlist] << song.title << ", "
      end
      @song_preview[playlist] = @song_preview[playlist][0,50]
      @song_preview[playlist] << "..."
    end
  end
end
