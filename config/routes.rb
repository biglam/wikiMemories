Rails.application.routes.draw do
  resources :groups
  resources :occasions
  resources :charities
  resources :pets
  resources :places
  resources :people do
    collection do
      get 'merge_records'
      get 'select_to_merge'
      get 'remove_administrator'
    end
  end
  resources :images do
    collection do
      get 'rank_up'
      get 'rank_down'
    end
  end
  resources :memories do
    collection do
      get 'rank_up'
      get 'rank_down'
      get 'flag_memory'
      get 'list_flagged'
      get 'list_orphaned'
      get 'delete_all_orphans'
      get 'reset_flag_count'
      get 'remove_item'
    end
  end
  resources :links

  get '/admin_tools' => 'pages#admin_tools'
  get '/faq' => 'pages#faq'
  get '/welcome' => 'pages#welcome'
  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'
  devise_for :users, :controllers => { registrations: 'registrations' }
resources :users, :only => [:show]
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
