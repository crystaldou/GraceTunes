Feature: display of the results page that after searching for a certain tag, artist, or title of a song, it generates a list of songs relevant to the search.

	As any user
	So that I can quickly search relevant praise songs
	I want to see songs matching the given criteria for my search

Background: songs have been added to database

	Given the following songs exist:
  	| title                   | artist                     | tags                                      | album                               | lyrics                |
  	| Your Love Never Fails   | Jesus Culture              | love, never fails                        | From The Inside Out                 | Your love never fails, never gives up, never runs out of on me.|
  	| Give Me Faith           | Elevation Worship          | faith, spirit, perseverance              | Kingdom Come                        | |
  	| From the Inside Out     | Hillsong United            | transformation, changed lives, failures  | United We Stand                     | |
  	| Glorious Day            | Casting Crowns             | salvation, rapture, where'd everyone go? | Until The Whole World Hears         | |
  	| Build Your Kingdom Here | Rend Collective Experiment | gospel, kingdom, church, on fire         | Homemade Worship By Handmade People | |
  	| Desert Soul             | Rend Collective Experiment | dry, dead, burnt out, perseverance       | Homemade Worship By Handmade People | |
  	| 10,000 Reasons          | Matt Redman                | blessings, worship, holy                 | 10,000 Reasons                      | |
  	| The Heart of Worship    | Matt Redman                | genuine, seeking, heart                  | Blessed Be Your Name                | |
  	| God Is Able             | Hillsong United            | powerful, hope, with us                  | God Is Able                         | |
  	| Commission My Soul      | Citipointe Live            | evangelism, purpose, great commission    | Commission My Soul: Present         | |
	| Let Me Sing			  | unknown					   | praise, 								  | unknown								| |
	Given the following playlists exist:
	| name                   | 
	| SWS11172013            |
	| SWS11102013            |
	
	And I am on the songs page
	
Scenario: search results to songs with title 'From the Inside Out'
	When I search by "Title" with "Inside Out"
	Then I should see "transformation"
	Then I should see "changed lives"
	Then I should see "failures"
	Then I should see "From the Inside Out" 
	Then I should see "Hillsong United"

Scenario: search results to songs with artist 'Matt'
	When I search by "Artist" with "Matt Redman"
	Then I should see "10,000 Reasons"
	Then I should see "The Heart of Worship"
		
Scenario: search results to songs with album 'Homemade Worship By Handmade People'
	When I search by "Album" with "Homemade Worship"
	Then I should see "Build Your Kingdom Here"		
	Then I should see "Desert Soul"
	
Scenario: search results to songs with tag 'perseverance'
  When I search by "Tags" with "perseverance"
  Then I should see "Give Me Faith"
  Then I should see "Elevation Worship"
  
Scenario: search results to songs with lyrics 'never runs out'
  When I search by "Lyrics" with "never runs out"
  Then I should see "Your Love Never Fails"
  Then I should see "Jesus Culture"