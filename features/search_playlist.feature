Feature: display of the results page that after searching for a certain title of the playlist, it generates a list of songs relevant to the search.

  As a church staff
  I want to search for playlists
  So that I can find playlists easily


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

	
	And I am on the songs page


    @omniauth_test
Scenario: search the playlist called "SWS11172013"
  And that user is signed in
  Given the following playlists exist:
	| name                   | 
	| SWS11172013            |
	| SWS11102013            |
	
	Given the following associations exist:
	| playlist               | song                       |
	| SWS11172013            | Your Love Never Fails      |
	| SWS11172013            | Give Me Faith              |
	| SWS11172013            | Glorious Day               |
	| SWS11102013            | Give Me Faith              |
  Given I am on the GraceTunes playlist page
  When I search "SWS11172013"
  Then I should see "SWS11172013"


