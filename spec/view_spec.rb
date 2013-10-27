require 'spec_helper'

describe SongsController, :type => :controller do
  before :each do
    @song = SongsController.new
  end
  
  describe "#view" do
    it "blah blah blah" do
      get :view
      response.should render_template :view
    end
  end
  
end