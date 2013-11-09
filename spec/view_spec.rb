require 'spec_helper'

describe SongsController, :type => :controller do
  before :each do
    @song = Songs.create({:title => "From the Inside Out"})
  end
  
  describe "#index" do
    it "blah blah blah" do
      get :index
      response.should render_template :index
    end
  end
  
  describe '#view' do
    it 'blah' do
      get :view
      response.should render_template :view
    end
    
    it 'blah2' do
      get :view, {:search_type => {:options => 'Title'}}
      response.should render_template :view
    end
    
    it 'blah3' do
      get :view, {:search_type => {:options => 'Album'}}
      response.should render_template :view
    end
    it 'blah4' do
      get :view, {:search_type => {:options => 'Artist'}}
      response.should render_template :view
    end
  end
  
  describe '#update' do
    it 'should redirect to show movie' do
      put :update , :id => @song.id, :song => {:title => @song.title}
      response.should redirect_to song_path(@song)
    end
  end
  
  describe '#show' do
    it 'should render show template with specific id' do
      get :show, :id => @song.id
      response.should render_template :show
    end
  end
  
  describe '#create' do
    it 'should create a movie and redirect to index page' do
      post :create
      response.should redirect_to songs_path
    end
  end
end