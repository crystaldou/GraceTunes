Feature: display of the playlists page that viewing playlist, it displays the songs contained in the playlist.

	As any user
	So that I can view songs in a playlist
	I want to see songs that are contained in a given playlist

Background: songs have been added to database, playlists have been added to database

	Given the following songs exist:
  	| title                   | artist                     | tags                                      | album                               | lyrics                |
  	| Your Love Never Fails   | Jesus Culture              | love, never fails                        | From The Inside Out                 | Your love never fails, never gives up, never runs out of on me.|
  	| Give Me Faith           | Elevation Worship          | faith, spirit, perseverance              | Kingdom Come                        | |
  	| From the Inside Out     | Hillsong United            | transformation, changed lives, failures  | United We Stand                     | |
  	| Glorious Day            | Casting Crowns             | salvation, rapture, where'd everyone go? | Until The Whole World Hears         | |
  	| Build Your Kingdom Here | Rend Collective Experiment | gospel, kingdom, church, on fire         | Homemade Worship By Handmade People | |
  	
  And I am on the playlist page
  
Scenario: create playlist
  When I add a new playlist
  I should see "Add a playlist"
	When I fill in "playlist_title" with "SWS11132013"
	And I press "Save Changes"
	Then I should see "Hello World was successfully created."
	
Scenario: add songs to playlists
  Given I am on the view page
  When I add "Your Love Never Fails" to playlist
  Then I should see "SWS11132013"
  When I follow "add to playlist"
  Then I should see "Your Love Never Fails added"