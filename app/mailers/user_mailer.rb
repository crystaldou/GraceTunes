class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def share_playlist(emailsString)
  	emails = emailsString.split(',')
  	emails.each do |email| 
  		mail(:to => email, :subject => 'Someone has shared a GraceTunes playlist with you!')
  	end 
  end 
end
