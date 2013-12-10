Feature: display of the playlists page that viewing playlist, it displays the songs contained in the playlist.

	As any user
	So that I can view songs in a playlist
	I want to see songs that are contained in a given playlist

Background: songs have been added to database, playlists have been added to database

	Given the following songs exist:
  	| title                   | artist                     | tags                                      | album                               | lyrics                |
  	| Your Love Never Fails   | Jesus Culture              | love, never fails                        | From The Inside Out                 | Your love never fails, never gives up, never runs out of on me.|


  And I am on the songs page
  

@omniauth_test
Scenario: add songs to playlists
  And that user is signed in
  
	Given the following playlists exist:
	| name                   |
	| SWS11172013            |
	| SWS11102013            |

  Given I am on the GraceTunes view page
  When I add "Your Love Never Fails" to playlist
  Then I should see "Your Love Never Fails was successfully added"