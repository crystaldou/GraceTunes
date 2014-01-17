require 'yomu'

class SongsController < ApplicationController

  # viewing a single song page
  def show
    id = params[:id] # retrieve movie ID from URI route
    @song = Songs.find(id) # look up movie by unique ID
    @link = findUrl(@song.chords.url)
  end

  def preview
     redirect_to ITunesSearchAPI.search(:term => params['title'], :country => "US", :media => "music", :limit => 1)[0]["previewUrl"]
  end
    
  def index
    if request.put?
      current_user.name = params['user']
      if params["admin_pass"] == "koinonia"
        current_user.admin = true
        flash[:notice] = "Admin created"
      else 
        flash[:notice] = "Wrong admin password"
      end
      current_user.save!
    end

  end

  def new
    # default: render 'new' template
    if not current_user.try(:admin?)
      render :template => "/errors/unauthorized.html.haml"
    end
  end

  def create
    tags = params[:tags].split(',').join(', ')
    @song = Songs.create!(params[:song])
    @song.tags = tags
    url = findUrl @song.chords.url
    @song.lyrics = parse(url)
    @song.save!
    flash[:notice] = "#{@song.title} was successfully created."
    redirect_to "/songs/#{@song.id.to_s}"
  end

  def findUrl chordUrl
    songIndex = chordUrl.index("song")
    if not songIndex.nil?
      url = "http://gracetunes.s3.amazonaws.com/" + chordUrl[songIndex...chordUrl.length]  
    end
    return url
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
      render :template => "/errors/not_found.html.haml"
    else
      songparam = params[:song]
      @song.update_attributes!(:title => songparam[:title], :artist => songparam[:artist], :album => songparam[:album], :tags => songparam[:tags])
      tags = params[:tags].split(',').join(', ')
      @song.tags = tags
      if not songparam[:file].nil?
        @song.update_attributes!(:chords => songparam[:file])
        @song.lyrics = parse(findUrl(@song.chords.url)).downcase
      end
      @song.save!
      flash[:notice] = "Song has been successfully edited"
      redirect_to "/songs/#{@song.id.to_s}"
    end

  end

  def destroy
    @song = Songs.find(params[:id])
    @song.chords.destroy
    @song.destroy
    flash[:notice] = "Successfully removed '#{@song.title}' "
    redirect_to songs_view_path
  end

  # viewing results page
  def view
    # @songs = list / something iterable.
    # each element should be a hash --> i.e. each song in @songs, you can do song.title, song.artist, song.tags
    # suggestion: for the file - instead of storing it in our app, could we link them to a dropbox or something
    # from where they can download the song?; so the hash would store the link.
  
    @type = params[:search_type]
    if @type
      @text = params[:search_text].split.map(&:capitalize).join(' ')
      @songs = Songs.searchText(@type, @text).paginate(:per_page => 10, :page => params[:page])
    else
      @songs = Songs.scoped.paginate(:per_page => 10, :page => params[:page])
    end
    @tags = {}
    @songs.each do |song|
      begin
        @tags[song] = song.tags.split(", ")
      rescue
        @tags[song] = []
      end
    end
    respond_to do |format|
      format.html {}
      format.js { render 'view'}
    end

  end
  
  def addtoplaylist
    @songId = params[:song_id]
    @playlistId = params[:playlist].split(", ")[1]
    @playlist = Playlist.find(@playlistId)
    @song = Songs.find(@songId)
    if @playlist.songss.include? @song
      flash[:notice] = "#{@song.title} is already in #{@playlist.name}"
      redirect_to request.referer and return
    end
    @playlist.songss << @song
    flash[:notice] = "#{@song.title} was successfully added"
    redirect_to request.referer
  end

  def addTags
    @song = Songs.find(params[:id])
    @song.update_attributes(:tags => params[:tags])
    flash[:notice] = "Tags have been added"
    redirect_to request.referer
  end
  # def test
  #   @texts = {}
  #   Dir['public/songs/*'].each do |file|
  #     yomu = Yomu.new file.to_s
  #     @texts[file] = [ yomu.text.gsub(/^$\n/, ''),
  #       yomu.text.split(/[\r\n]/).map{|l| line_remove(l.gsub(/[^[:ascii:]]/i,'').gsub(/\s+/, ' ').strip)}.join("\n").gsub(/^$\n/, '') ]
  #   end
  # end

  def parse file
    yomu = Yomu.new file
    return yomu.text.split(/[\r\n]/).map{|l| line_remove(l.gsub(/[^[:ascii:]]/i,'').gsub(/\s+/, ' ').strip)}.join("\n").gsub(/^$\n/, '')
  end

  def line_remove line
    regex = [ /^(\(\s?)?(b|bridge|chordsheet|c|chorus|coda|e||ending|f|full chorus|i|inst|instrumental|intro|p|pre-chorus|r|repeat|v|verse)?(\s?(\w|\d+))?(\s?:)?(\s?\d+\s?(x|times))?(\s?(x|times)\s?\d+)?(\)\s?)?$/i,
              /^(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?(\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?)*$/,
              /^(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?\s/,
              /\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?$/,
              /\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?\s(\(\s?)?[A-G](#|b)?[M|m]?s?\d?\d?(\s?(\/|\\)\s?[A-G](#|b)?[M|m]?s?\d?\d?)?(\s?\))?\s/,
              /\d?\d\s?(\/|\\)\s?\d?\d\s?(\/|\\)\s?\d\d(\d\d)?/,
              /page(\s?\d+)?/i,
              /ccli/i,
              /^[^\w]+$/ ]
    regex.each do |r|
      if r =~ line
        return ''
      end
    end
    return line
  end
end
