ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'GraceTunes2013@gmail.com',
  :password       => 'koinonia',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}