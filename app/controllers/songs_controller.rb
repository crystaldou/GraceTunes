require 'yomu'

class SongsController < ApplicationController

  # viewing a single song page
  def show
    id = params[:id] # retrieve movie ID from URI route
    @song = Songs.find(id) # look up movie by unique ID
  end

  def index
    @a = "index"
  end

  def new
    # default: render 'new' template
  end

  def create
    @song = Songs.create!(params[:song])
    flash[:notice] = "#{@song.title} was successfully created."
    redirect_to songs_path
  end

  # edit_song_path(song)
  # Edit page for a song
  def edit
    @song = Songs.find params[:id]
  end

  # go here when click submit after editing a page
  def update
    @song = Songs.find params[:id]
    if params[:song][:title].empty?
      #how to raise a field error??
      raise "Cannot leave song field empty"
    else
      @song.update_attributes!(params[:song])
      flash[:notice] = "Song has been successfully edited"
      redirect_to "/songs/#{@song.id.to_s}"
    end

  end

  def destroy
    @song = Songs.find(params[:id])
    @song.destroy
    flash[:notice] = "Successfully removed '#{@song.title}' "
    redirect_to songs_path
  end

  # viewing results page
  def view
    # @songs = list / something iterable.
    # each element should be a hash --> i.e. each song in @songs, you can do song.title, song.artist, song.tags
    # suggestion: for the file - instead of storing it in our app, could we link them to a dropbox or something
    # from where they can download the song?; so the hash would store the link.
    @type = params[:search_type]
    @text = params[:search_text]
    if @type
      if @type[:options] == "Title"
        @songs = Songs.where(title: @text)
      elsif @type[:options] == "Artist"
        @songs = Songs.where(artist: @text)
      elsif @type[:options] == "Album"
        @songs = Songs.where(album: @text)
      end
    else
      @songs = Songs.all
    end
  end

  def test
    @texts = {}
    Dir['public/songs/*'].each do |file|
      yomu = Yomu.new file.to_s
      @texts[file] = [ yomu.text, yomu.text.gsub(/^$\n/, '') ]
    end
  end
end
