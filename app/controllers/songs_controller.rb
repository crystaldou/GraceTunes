class SongsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @song = Songs.find(id) # look up movie by unique ID
    
  end

  def index
    
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


end
