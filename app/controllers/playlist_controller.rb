class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    if current_user != nil
      @playlists = Playlist.where(:user_id => current_user.uid)
    else
      @playlists = Playlist.all
    end
    @playlists = Playlist.all
    @song_preview = {}
    @playlists.each do |playlist|
      @song_preview[playlist] = ""
      playlist.songss.each do |song|
        @song_preview[playlist] << song.title << ", "
      end
      @song_preview[playlist] = @song_preview[playlist][0..-3] + " "
      @song_preview[playlist] = @song_preview[playlist][0,50]
      @song_preview[playlist] << "..."
    end
  end
  

  def create
    @playlists = Playlist.create!(params[:playlist])
    flash[:notice] = "Created empty playlist"
    redirect_to playlist_path
  end
 def destroy
    @playlists = Playlist.find(params[:id])
    @playlists.destroy
    flash[:notice] = "#{@playlists.title}' deleted."
    redirect_to playlist_path
  end

end
