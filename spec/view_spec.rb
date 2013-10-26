require 'spec_helper'

describe Songs do
  before :each do
    @song = Songs.new do |s|
      s.title = "blah"
      s.artist = "b"
    end
  end
  
  describe "#new" do
    it "blah blah blah" do
      @song.should be_an_instance_of Songs
    end
  end
  
end