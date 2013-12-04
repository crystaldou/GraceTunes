class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :image
  has_and_belongs_to_many :playlists
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
    end
  end
end
