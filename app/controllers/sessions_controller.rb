class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user.nil?
      user = User.create_with_omniauth(auth)
      favorites_playlist = Playlist.create({:name => "#{user.name}'s Favorites"})
      favorites_playlist.users << user
      favorites_playlist.save!
      user.favorites_playlist_id = favorites_playlist.id
      user.save!
    end
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out"
  end
  
  def edit
  end
  
end
