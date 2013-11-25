ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['GraceTunes2013@gmail.com'],
  :password       => ENV['koinonia'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}