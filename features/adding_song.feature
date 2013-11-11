Feature: Add a song with title, artist, tag, and album fields

	As a praise leader
	So that I can quickly add a new song into our database of praise songs
	I want to add a new song

	Given I am on the GraceTunes songs page

	Scenario:

	When I add a new song
	Then I should see "Create New Song"
	When I fill in "song_title" with "Hello World"
	And I fill in "song_artist" with "Jon Ching"
	And I fill in "song_album" with "Herp Derp"
	And I fill in "song_tags" with "Alec, Hoey, Is, Awesome"
	And I attach the file "lyrics.doc" to "song_file"
	And I press "Save Changes"
	Then I should see "Hello World was successfully created."




