class PlaylistController < ApplicationController
  # viewing all playlists
  def index
    @text = params[:search_text]
    if not current_user.nil? and not @text.nil?
      @playlists = User.find(current_user.id).playlists.searchList(@text).paginate(:per_page => 20, :page => params[:page])
    elsif @text.nil? and not current_user.nil?
      @playlists = User.find(current_user.id).playlists.paginate(:per_page => 20, :page => params[:page])
    else
      @playlists = Playlist.all
    end
    @song_preview = Playlist.createPreview @playlists
    respond_to do |format|
      format.html {}
      format.js { render 'view'}
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
    @playlist = Playlist.find_by_token(params[:id])
    if current_user.nil?
      redirect_to '/auth/google_oauth2' and return
    end
    if not @playlist.users.map { |user| user.id }.include? current_user.try(:id)
      @playlist.users << User.find(current_user.try(:id))
    end
    @songs = @playlist.songss
  end
  
  def viewSong
    @previews = [Songs.find(params[:id])]
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
      content += counter.to_s + '. ' + song.title + "\t" + song.artist + "\t" + song.album + "\t" +  song.tags + "\n"
      counter += 1
    end 
    UserMailer.share_playlist(params[:emails].split(','), content, playlist).deliver
    flash.keep[:notice] = "#{@playlist} successfully shared."
    redirect_to playlist_path(playlist.token)
  end 
end
