Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '89979976718.apps.googleusercontent.com', 'Rh1Aw7MA3bCWAGhJGC_s4niG', {access_type: 'online', approval_prompt: ''}
end