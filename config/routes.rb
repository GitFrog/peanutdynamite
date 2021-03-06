DeadGrandmaCookies::Application.routes.draw do resources :home

  get "recipes/shortcut"
  get "recipes/index"
  get "recipes/show"

  get "stories/scrollup"
  get "pages/about"
  get "pages/home"
  get "users/new"  
  get "users/index"
  get "users/indexstories"

  get "viewers/index"
  get "viewers/indexstories"
  get "recipefavourites/destroy"
  get "recipefavourites/update"
  get "recipefavourites/create"
  

  root :to => "pages#home"
  resources :pages
  resources :recipes
  resources :stories
  resources :users
  resources :viewers
  resources :recipefavourites
  resources :sessions, :only => [:new, :create, :destroy]

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  resources :viewers do
    collection do
      get :index, :as => :index
    end
  end

  resources :users do
    collection do
      get :index, :as => :index
    end
  end

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
  
  #root :to => "recipes#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
