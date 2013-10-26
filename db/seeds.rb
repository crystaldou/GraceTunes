# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

songs = [{:title => 'Your Love Never Fails', :artist => 'Jesus Culture', :album => 'From The Inside Out', :tags => 'love, never fails'},
      	  {:title => 'Give Me Faith', :artist => 'Elevation Worship', :album => 'Kingdom Come', :tags => 'faith, spirit, perseverance'},
  	 ]


songs.each do |song|
  Songs.create!(song)
end