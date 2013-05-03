Inf::Application.routes.draw do

  resources :courses

  resources :s3_uploads

  resources :global_search, path: "busca"

  resources :projects, path: "projetos", :path_names => { new: "novo", edit: "editar" }
  resources :people, path: "usuarios", :path_names => { new: "novo", edit: "editar" }, constraints: { :id => /[^\/]+/ }
  resources :home, :tags, :comments, :activities
  devise_for :users, :controllers => { :registrations  => "registrations" }, path: "", :path_names => { sign_in: 'entrar', sign_out: 'logout', sign_up: "cadastro"}

  match 'usuarios/:id' => 'People#show', :as => 'profile'

  root :to => "home#show"
  match 'sobre' => 'Home#about', :as => 'about', :via => :get  

  
  # match 'people/:name/deleteAvatar' => 'People#deleteAvatar', :as => 'deleteAvatar'

  # Github style project URL
  # match 'p/:person/:project' => 'Projects#show', :as => 'person_project', constraints: { :project => /[^\/]+/, :person => /[^\/]+/ }

  match 'project/like/:id' => 'Projects#like', :as => 'like_project'
  match 'project/unlike/:id' => 'Projects#unlike', :as => 'unlike_project'
  match 'project/:id/download' => 'Projects#downloadFile', :as => 'project_download'
  match 'project/:id/link' => 'Projects#clickLink', :as => 'project_link'


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
end
