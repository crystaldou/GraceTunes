require 'spec_helper'

describe SongsController, :type => :controller do
  before :each do
    @song = SongsController.new
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
      response.should render_template :index
    end
  end
  
end