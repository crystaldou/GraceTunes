class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    if not current_user.nil?
      @playlists = User.find(current_user.id).playlists
    else
      @playlists = Playlist.all
    end
    @song_preview = {}
    @playlists.each do |playlist|
      @song_preview[playlist] = ""
      playlist.songss.each do |song|
        @song_preview[playlist] << song.title << ", "
      end
      @song_preview[playlist] = @song_preview[playlist][0...-2]
      max_length = 150
      if @song_preview[playlist].length > max_length
        @song_preview[playlist] = @song_preview[playlist][0,max_length]
        if @song_preview[playlist][max_length] == ','
          @song_preview[playlist] = @song_preview[playlist][0...max_length-1]
        end
        @song_preview[playlist] << "..."
      end
    end
  end
  
  def new
    if not current_user.try(:admin?)
      render :template => "/errors/unauthorized.html.haml"
    end
  end
  
  def create
    @playlist = Playlist.create(:name => params[:playlist_name])
    @playlist.users << User.find(current_user.try(:id))
    @playlist.save!
    flash[:notice] = "Created empty playlist"
    redirect_to playlist_path(@playlist.token)
  end
  
 def destroy
    @playlists = Playlist.find_by_token(params[:id])
    @playlists.destroy
    flash[:notice] = "#{@playlists.name}' deleted."
    redirect_to playlist_path
  end

  def show
    id = params[:id]
    @playlist = Playlist.find_by_token(id)
    if not @playlist.users.map { |user| user.id }.include? current_user.try(:id)
      @playlist.users << User.find(current_user.try(:id))
    end
    @songs = @playlist.songss
    @tags = {}
    @songs.each do |song|
      begin
        @tags[song] = songs.tags.split(", ")
      rescue
        @tags[song] = []
      end
    end
  end
  
  def viewSong
    id = params[:id]
    @previews = [Songs.find(id)]
    respond_to do |format|
      format.html { render :partial =>'preview', :collection => @previews}
      format.js { }
    end
  end

  def share
    playlist = Playlist.find_by_token(params[:id])
    content = ""
    counter = 1
    playlist.songss.each do |song| 
      content += counter.to_s + '. ' 
      content += song.title + '\t'
      content += song.artist + '\t'
      content += song.album + '\t'
      content += song.tags + '\n'
      counter += 1
    end 
    emails = params[:emails].split(',')
    UserMailer.share_playlist(emails, content, playlist).deliver
    flash.keep[:notice] = "#{@playlist} successfully shared."
    redirect_to playlist_path(playlist.token)
  end 
end
