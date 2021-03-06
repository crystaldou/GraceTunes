Feature: Edit a pre-existing song's fields and tags 

	As a praiser leader  
	So that I can quickly edit wrong fields 
	I want to edit/add fields and tags for songs 

Background: songs have been added to database

Given the following songs exist:
  	| title                   | artist                     | tags                                     | album                               |
  	| Your Love Never Fails   | Jesus Culture              | love, never fails                        | From The Inside Out                 |
  	| Give Me Faith           | Elevation Worship          | faith, spirit, perseverance              | From The Inside Out                 |
  	| From the Inside Out     | Hillsong United            | transformation, changed lives, failures  | United We Stand                     |
  	| Glorious Day            | Casting Crowns             | salvation, rapture, where'd everyone go? | Until The Whole World Hears         |
  	| Build Your Kingdom Here | Rend Collective Experiment | gospel, kingdom, church, on fire         | Homemade Worship By Handmade People |
  	| Desert Soul             | Rend Collective Experiment | dead, burnt out, perseverance      	  | Homemade Worship By Handmade People |
  	| 10,000 Reasons          | Matt Redman                | blessings, worship, holy                 | 10,000 Reasons                      |
  	| The Heart of Worship    | Matt Redman                | genuine, seeking, heart                  | Blessed Be Your Name                |
  	| God Is Able             | Hillsong United            | powerful, hope, with us                  | God Is Able                         |
  	| Commission My Soul      | Citipointe Live            | evangelism, purpose, great commission    | Commission My Soul: Present         |

  And I am on the GraceTunes view page 

Scenario: 

	When I edit "Desert Soul"
	Then the "song_title" field should contain "Desert Soul"
	Then the "song_tags" field should contain "dead, burnt out, perseverance"
	Then the "song_album" field should contain "Homemade Worship By Handmade People" 
	Then the "song_artist" field should contain "Rend Collective Experiment"
	
	When I fill in "song_tags" with "dry, dead, burnt out, perseverance" 
	When I attach the file "lyrics.doc" to "song_file"
    When I press "submit_song"
	And I should see "Song has been successfully edited"

Scenario:

	When I edit "Give Me Faith"
	Then the "song_title" field should contain "Give Me Faith"
	Then the "song_tags" field should contain "faith, spirit, perseverance" 
	Then the "song_album" field should contain "From The Inside Out" 
	Then the "song_artist" field should contain "Elevation Worship"

	When I fill in "song_album" with "Kingdom Come" 
    When I attach the file "lyrics.doc" to "song_file"
	When I press "submit_song"
	And I should see "Song has been successfully edited"













