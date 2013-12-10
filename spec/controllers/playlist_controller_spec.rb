require 'spec_helper'

describe PlaylistController do
  before :each do
    @playlist = Playlist.create({:name => "name"})
    @song = Songs.create({:title => "title", :artist => "artist", :album => "album", :tags => "blah", :file => {:current_path => "blah"}})
    @playlist.songss << @song
    @user = mock_model(User, :name => 'test')
    @playlist.users << @user
    User.stub(:find).and_return(@user)
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
      response.should redirect_to playlist_path(Playlist.find(2).token)
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
      get 'viewSong', :id => 1
    end
    
    it 'blah3' do
      File.should_receive(:read).at_least(:once)
      post 'share', :id => @playlist.token, :emails => "blah"
      response.should redirect_to playlist_path(@playlist.token)
    end
  end

end
