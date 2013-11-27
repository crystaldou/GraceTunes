require 'spec_helper'

describe SongsController, :type => :controller do
  before :each do
    @song = Songs.create({:title => "From the Inside Out", :tags => 'perseverance', :file => 'data/12/Mighty_To_Save.doc'})
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
      get :view, {:search_type => 'Title', :search_text => 'From the Inside Out'}
      response.should render_template :view
    end
    
    it 'blah3' do
      get :view, {:search_type => 'Album', :search_text => 'United We Stand'}
      response.should render_template :view
    end
    it 'blah4' do
      get :view, {:search_type => 'Artist', :search_text => 'Hillsong United'}
      response.should render_template :view
    end
    
    it 'blah5' do
      get :view
      response.should render_template :view
    end
  end
  
  describe '#update' do
    it 'should redirect to show movie' do
      controller.stub(:parse).and_return('')
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
    it 'should create a movie and redirect to show page' do
      controller.stub(:parse).and_return('')
      post :create, :song => {:file => 'data/12/Mighty_To_Save.doc'}
      response.should redirect_to song_path(2)
    end
  end
    
  describe '#destroy' do
    it 'should destroy' do
      delete :destroy, :id => @song.id
      response.should redirect_to songs_view_path
    end
  end
  
  describe '#line_remove' do
    it 'should lineremove' do
      controller.line_remove('')
    end
  end
end