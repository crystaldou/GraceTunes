class UserMailer < ActionMailer::Base
  default from: "GraceTunes2013@gmail.com"
  def share_playlist(emails, playlist, content)
  	@content = playlist
  	content.songss.each do |song|
  	  begin
  	    songIndex = chordUrl.index("song")
        if not songIndex.nil?
          url = "http://gracetunes.s3.amazonaws.com/" + chordUrl[songIndex...chordUrl.length]  
        end
  	    attachments[song.chords.original_filename] = File.read(url)
	    rescue
      end
	  end
	  @token = content.token
    emails.each do |email| 
  		mail(:to => email, :subject => 'Someone has shared a GraceTunes playlist with you!')
  	end 
  end 
end
