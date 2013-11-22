require 'yomu'

class SongsController < ApplicationController

  # viewing a single song page
  def show
    id = params[:id] # retrieve movie ID from URI route
    @song = Songs.find(id) # look up movie by unique ID

    if @song.file
      @link = @song.file.to_s
    else
      @link = "/songs/#{@song.id.to_s}"
    end
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
      raise ArgumentError, "You are not an admin"
    end
  end

  def create
    @song = Songs.create!(params[:song])
    @song.lyrics = parse("public/#{@song.file}")
    @song.save!
    flash[:notice] = "#{@song.title} was successfully created."
    redirect_to "/songs/#{@song.id.to_s}"
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
      @song.lyrics = parse("public/#{@song.file}").downcase
      @song.save!
      flash[:notice] = "Song has been successfully edited"
      redirect_to "/songs/#{@song.id.to_s}"
    end

  end

  def destroy
    @song = Songs.find(params[:id])
    @song.remove_file!
    system "rm -rf public/data/#{@song.id.to_s}"
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
      if @type == "Title"
        @songs = Songs.where("title LIKE '%#{@text}%'")
      elsif @type == "Artist"
        @songs = Songs.where("artist LIKE '%#{@text}%'")
      elsif @type == "Album"
        @songs = Songs.where("album LIKE '%#{@text}%'")
      elsif @type == "Tags"
        @songs = Songs.where("tags LIKE '%#{@text.downcase}%'")
      elsif @type == "Lyrics"
        if ActiveRecord::Base.connection.instance_values["config"][:adapter] != "sqlite3"
          @songs = Songs.search_lyrics(@text.downcase)
        else
          @songs = Songs.where("lyrics LIKE '%#{@text.downcase}%'")
        end
      end
    else
      @songs = Songs.all
    end
    @tags = {}
    @songs.each do |song|
      begin
        @tags[song] = song.tags.split(", ")
      rescue
        @tags[song] = []
      end
    end

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
