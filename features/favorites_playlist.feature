Feature: display favorites playlist after logging in as a new user.

  As a church staff
  I want to have a favorites playlist
  So that I can keep track of my favorite songs


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
	
  And I am on the GraceTunes view page
  
  @omniauth_test
Scenario: have favorites playlist
  And that user is signed in
  And I follow "Browse Sets"
  Then I should see "Favorites"
  Given I am on the GraceTunes playlist page
  Then I should see "Favorites"


