class SongsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @song = Songs.find(id) # look up movie by unique ID
    
  end

  def index
    @a = "index"
  end

  def view
    # @songs = list / something iterable.
    # each element should be a hash --> i.e. each song in @songs, you can do song.title, song.artist, song.tags
    # suggestion: for the file - instead of storing it in our app, could we link them to a dropbox or something
    # from where they can download the song?; so the hash would store the link.
  end

  def new
    # default: render 'new' template
  end

  def create
    @song = Songs.create!(params[:song])
    flash[:notice] = "#{@song.title} was successfully created."
    redirect_to songs_path
  end

  def edit
    @song = Songs.find params[:id]
  end

  def update
    @song = Songs.find params[:id]
    @song.update_attributes!(params[:movie])
    flash[:notice] = "#{@song.title} was successfully updated."
    redirect_to songs_path(@song)
  end

  def destroy
    @song = Songs.find(params[:id])
    @song.destroy
    flash[:notice] = "Successfully removed '#{@song.title}' "
    redirect_to songs_path
  end
  
  def view
    @type = params[:search_type]
    @text = params[:search_text]
    if @type == "title"
      @songs = Songs.where(title: @text)
    elsif @type == "artist"
      @songs = Songs.where(artist: @text)
    end
  end
end
