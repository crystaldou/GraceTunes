require 'spec_helper'

describe PlaylistController do
  before :each do
    @playlist = Playlist.create({:name => "name"})
    @song = Songs.create({:title => "title", :artist => "artist", :album => "album", :tags => "blah"})
    @playlist.songss << @song
    
    stub_env_for_omniauth
    redirect_to '/auth/google_oauth2'
  end
  describe "GET 'index'" do
    it "blah" do
      get 'index'
      response.should render_template :index
    end
  end
  
  describe 'create' do
    it 'blah' do
      post 'create', :playlist_name => "name"
      response.should redirect_to playlist_path(2)
    end
  end
  
  describe 'show' do
    it 'blah' do
      get 'show', :id => @playlist.token
      response.should render_template :show
    end
  end
  
  describe 'destroy' do
    it 'blah3' do
      delete 'destroy', :id => @playlist.token
      response.should redirect_to playlist_path
    end
  end
  
  describe 'blah' do
    it 'should lineremove' do
      get 'viewSong', :id => @playlist.token
    end
    
    it 'blah3' do
      post 'share', :id => @playlist.token, :emails => "blah"
      response.should redirect_to playlist_path(1)
    end
  end

end


def stub_env_for_omniauth
  env = { "omniauth.auth" => { "provider" => "google", "uid" => "1234", "extra" => { "user_hash" => { "email" => "ghost@nobody.com" } } } }
  @controller.stub!(:env).and_return(env)
end
