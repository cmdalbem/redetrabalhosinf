Rails.application.routes.draw do
  resources :courses

  resources :s3_uploads

  resources :global_search, path: "busca"
  resources :search_logs
  resources :links

  resources :projects, path: "trabalhos", :path_names => { new: "novo", edit: "editar" }
  resources :people, path: "usuarios", :path_names => { new: "novo", edit: "editar" }, constraints: { :id => /[^\/]+/ }
  resources :home, :tags, :comments, :activities
  devise_for :users, :controllers => { :registrations  => "registrations", confirmations: 'confirmations' }, path: "", :path_names => { sign_in: 'entrar', sign_out: 'logout', sign_up: "cadastro"}

  match 'usuarios/:id' => 'people#show', :as => 'profile', via: [:get]
  # match 'usuarios/:id/trabalhos' => 'projects#index', :as => 'myProjects'

  root :to => "home#show"
  match 'sobre' => 'home#about', :as => 'about', :via => :get  

  
  # match 'people/:name/deleteAvatar' => 'people#deleteAvatar', :as => 'deleteAvatar'

  # Github style project URL
  # match 'p/:person/:project' => 'projects#show', :as => 'person_project', constraints: { :project => /[^\/]+/, :person => /[^\/]+/ }

  match 'trabalhos/:id/favorite' => 'projects#favorite', :as => 'favorite_project', via: [:get, :post]
  match 'trabalhos/:id/like' => 'projects#like', :as => 'like_project', via: [:get, :post]
  match 'trabalhos/:id/unlike' => 'projects#unlike', :as => 'unlike_project', via: [:get, :post]
  match 'trabalhos/:id/download' => 'projects#downloadFile', :as => 'project_download', via: [:get, :post]
  match 'trabalhos/:id/link' => 'projects#clickLink', :as => 'project_link', via: [:get, :post]

  # match 'meustrabalhos' => 'projects#myProjects', :as => 'myProjects', :via => :get  

  
  
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
