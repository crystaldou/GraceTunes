class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    @playlists = Playlist.all
  end

end
