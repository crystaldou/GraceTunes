Gracetunes::Application.routes.draw do
  get "errors/server_error"

  get "errors/not_found"

  get "playlists/view"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # get '/songs/test', to: 'songs#test'
  get '/songs/view', to: 'songs#view'
  resources :songs
  resources :playlist
  root :to => 'songs#index'
  post '/playlist/new', to: 'playlist#create'
  post '/songs/view', to: 'songs#addtoplaylist'
  match "/playlists/viewSong" => "playlist#viewSong"
  match "/user/edit" => "sessions#edit"
  match "/auth/google_oauth2/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as  => :signout
  match '/playlist/:id/share', :to => 'playlist#share'
  match '/previewSong', :to => 'songs#preview'
  match '/songs/:id/addTags', :to => 'songs#addTags'
  match "/401", to: "errors#unauthorized"
  match "/404", to: "errors#not_found"
  match "/500", to: "errors#error"
  match '/deleteFromPlaylist' => "playlist#deleteFromPlaylist"

end
