class PlaylistsController < ApplicationController
  # viewing all playlists
  def index
    @playlists = Playlists.all
  end

end
