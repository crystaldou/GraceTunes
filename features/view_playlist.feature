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
  
  	Given the following playlists exist:
  	| name                   | 
  	| SWS11172013   |
  	| SWS11102013 |
  	
  	Given the following associations exist:
  	| playlist               | song                       |
  	| SWS11172013            | Your Love Never Fails      |
  	| SWS11172013            | Give Me Faith              |
  	| SWS11172013            | Glorious Day               |
  	
    And I am on the playlists page
    
Scenario: see the songs in a playlist called "SWS11172013"
  When I visit "SWS11172013"
  Then I should see "Your Love Never Fails"
  Then I should see "Give Me Faith"
  Then I should see "Glorious Day"
  Then I should see "faith"
  Then I should see "love"
  Then I should not see "From the Inside Out"
  
  
	