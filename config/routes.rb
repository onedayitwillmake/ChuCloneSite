ChuCloneSite::Application.routes.draw do

	#resources :highscores

	# AUTHENTICATION
	match "/auth/twitter/callback" => "sessions#create"
	match "/signout" => "sessions#destroy", :as => :signout

	# LEVELS
	get "levels/data/:id" => "levels#data"
	get "levels/data" => "levels#data"
	match "levels/reorder/" => "levels#reorder", :as => :reorder
	match "levels/reorder/save" => "levels#save_order"
	match "levels/create_from_editor" => "levels#create_from_editor"

	# GAME
	match "editor/:id" => "game#edit", :as => :editor
	match "editor" => "game#edit"
	match "pure/:id" => "game#pure"
	match "remoteplay/" => "game#remoteplay"
	match "remoteplay/:id" => "game#remoteplay"

	# RESOURCE MAPPING
	# resources :users
	resources :game

	# LEVELS AND HIGHSCORES
	resources :levels do
		resources :highscores
	end


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
	root :to => "game#index"

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
