Feature: display of the results page that after searching for a certain tag, artist, or title of a song, it generates a list of songs relevant to the search.

	As any user
	So that I can quickly search relevant praise songs
	I want to see songs matching the given criteria for my search

Background: songs have been added to database

	Given the following songs exist:
  	| title                   | artist                     | tags                                      | album                               |
  	| Your Love Never Fails   | Jesus Culture              | love, never fails                        | From The Inside Out                 |
  	| Give Me Faith           | Elevation Worship          | faith, spirit, perseverance              | Kingdom Come                        |
  	| From the Inside Out     | Hillsong United            | transformation, changed lives, failures  | United We Stand                     |
  	| Glorious Day            | Casting Crowns             | salvation, rapture, where'd everyone go? | Until The Whole World Hears         |
  	| Build Your Kingdom Here | Rend Collective Experiment | gospel, kingdom, church, on fire         | Homemade Worship By Handmade People |
  	| Desert Soul             | Rend Collective Experiment | dry, dead, burnt out, perseverance       | Homemade Worship By Handmade People |
  	| 10,000 Reasons          | Matt Redman                | blessings, worship, holy                 | 10,000 Reasons                      |
  	| The Heart of Worship    | Matt Redman                | genuine, seeking, heart                  | Blessed Be Your Name                |
  	| God Is Able             | Hillsong United            | powerful, hope, with us                  | God Is Able                         |
  	| Commission My Soul      | Citipointe Live            | evangelism, purpose, great commission    | Commission My Soul: Present         |
	| Let Me Sing			  | unknown					   | praise, 								  | unknown								|

	And I am on the songs page
	
Scenario: search results to songs with title 'From the Inside Out'
	When I search by "title" with "From the Inside Out"
	Then I should see "transformation, changed lives, failures"
	Then I should see "From the Inside Out" 
	Then I should see "Hillsong United"

Scenario: search results to songs with artist 'Matt Redman'
	When I search by "artist" with "Matt Redman"
	Then I should see "10,000 Reasons"
	Then I should see "The Heart of Worship"
		
Scenario: search results to songs with album 'Homemade Worship By Handmade People'
	When I search by "album" with "Homemade Worship By Handmade People"
	Then I should see "Build Your Kingdom Here"		
	Then I should see "Desert Soul"
	