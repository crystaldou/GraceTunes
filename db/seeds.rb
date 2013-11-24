# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

songs = [{:title => 'Your Love Never Fails', :artist => 'Jesus Culture', :album => 'From The Inside Out', :tags => 'love, never fails'},
      	  {:title => 'Give Me Faith', :artist => 'Elevation Worship', :album => 'Kingdom Come', :tags => 'faith, spirit, perseverance'},
  	  {:title => 'From the Inside Out', :artist => 'Hillsong United', :album => 'United We Stand', :tags => 'transformation, changed lives, failures'},
  	  
  	  {:title => 'Glorious Day', :artist => 'Casting Crowns', :album => 'Until The Whole World Hears', :tags => 'salvation, rapture, where\'d everyone go?'},
  	  {:title => 'Build Your Kingdom Here', :artist => 'Rend Collective Experiment', :album => 'Homemade Worship By Handmade People', :tags => 'gospel, kingdom, church, on fire'},
  	  {:title => 'Desert Soul', :artist => 'Rend Collective Experiment', :album => 'Homemade Worship By Handmade People', :tags => 'dead, burnt out, perseverance'},
  	  {:title => '10,000 Reasons', :artist => 'Matt Redman', :album => '10,000 Reasons', :tags => 'blessings, worship, holy'},
  	  {:title => 'The Heart of Worship', :artist => 'Matt Redman', :album => 'Blessed Be Your Name', :tags => 'genuine, seeking, heart'},
  	  {:title => 'God Is Able', :artist => 'Hillsong United', :album => 'God Is Able', :tags => 'powerful, hope, with us'},
  	  {:title => 'Commission My Soul', :artist => 'Citipointe Live', :album => 'Commission My Soul: Present', :tags => 'evangelism, purpose, great commission'}
  	 ]
Songs.destroy_all
  	 
songs.each do |song|
  Songs.create!(song)
end

playlists = [{:name => 'SWS111312'}, {:name => 'SWS112012'}]
playlists.each do |playlist|
  Playlist.create!(playlist)
end

songs_in_playlists = [[Songs.where(:title => 'Your Love Never Fails'), Songs.where(:title => 'Give Me Faith'),
                       Songs.where(:title => 'From the Inside Out'), Songs.where(:title => 'Glorious Day'),
                       Songs.where(:title => 'Build Your Kingdom Here'), Songs.where(:title => 'Desert Soul'),
                       Songs.where(:title => '10,000 Reasons'), Songs.where(:title => 'The Heart of Worship'),
                       Songs.where(:title => 'God Is Able'), Songs.where(:title => 'Commission My Soul')],
                      [Songs.where(:title => 'Your Love Never Fails'), Songs.where(:title => '10,000 Reasons'),
                       Songs.where(:title => 'God Is Able')]]
p_id = 1
songs_in_playlists.each do |list_of_songs|
  list_of_songs.each do |song|
    Playlist.find(p_id).songss << song
  end
  p_id += 1
end