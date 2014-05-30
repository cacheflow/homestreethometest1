Homestreetapp::Application.routes.draw do
  get "statuses/new"
  get "statuses/create"
  get "statuses/show"
  get "statuses/index"
  get "donations/new"
  get "donations/create"
  get "donations/show"
  get "donations/index"
  get "donors/new"
  get "donors/create"
  get "donors/edit"
  get "donors/update"
  get "residents/new"
  get "residents/create"
  get "residents/edit"
  get "residents/update"
  get "residents/show"
  get "residents/index"
  get "donation/new"
  get "donation/create"
  get "donation/show"
  get "donation/index"
  get "donor/new"
  get "donor/create"
  get "donor/edit"
  get "donor/update"
  get "resident/new"
  get "resident/create"
  get "resident/index"
  get "resident/edit"
  get "resident/update"
  get "resident/show"
  devise_for :users
  resources :partners
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
