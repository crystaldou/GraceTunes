Feature: Add a song with title, artist, tag, and album fields 

	As a praise leader 
	So that I can quickly add a new song into our database of praise songs 
	I want to add a new song 

	Given I am on the GraceTunes songs page

	Scenario: 
	
	When I follow "Add a song"
	Then I should see "Upload Window"
	When I attach the file "/home/saasbook/Desktop/CS/GraceTunes/lyrics.pdf" to "song_lyrics"
	Then I should be on the edit page

	
	

