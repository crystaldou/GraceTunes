require 'spec_helper'

describe PlaylistController do
  before :each do
    @playlist = Playlist.create({:name => "name"})
    @song = Songs.create({:title => "title", :artist => "artist", :album => "album", :tags => "blah"})
    @playlist.songss << @song
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
      get 'show', :id => 1
      response.should render_template :show
    end
  end
  
  describe 'destroy' do
    it 'blah3' do
      delete 'destroy', :id => 1
      response.should redirect_to playlist_path
    end
  end
  
  describe 'blah' do
    it 'should lineremove' do
      get 'viewSong', :id => 1
    end
    
    it 'blah3' do
      post 'share', :id =>1, :emails => "blah"
      response.should redirect_to playlist_path(1)
    end
  end

end
