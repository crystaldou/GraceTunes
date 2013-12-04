class UserMailer < ActionMailer::Base
  default from: "GraceTunes2013@gmail.com"
  def share_playlist(emails, playlist, content)
  	@content = playlist
  	content.songss.each do |song|
  	  file = song.file.to_s
  	  file[0] = ''
  	  attachments['test#{song.id}'] = File.read("public/#{song.file}")
	  end
	  @token = content.token
    emails.each do |email| 
  		mail(:to => email, :subject => 'Someone has shared a GraceTunes playlist with you!')
  	end 
  end 
end
