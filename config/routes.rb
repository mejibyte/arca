ActionController::Routing::Routes.draw do |map|
  map.resources :exalumnos

  map.resources :grupos, :member => { :quitar_profesor => :put, :agregar_profesor => :put, :agregar_alumnos => :put, :quitar_alumnos => :put }
  map.resources :grupos, :member => { :agregar_profesor => :get, :agregar_alumnos => :get, :quitar_alumnos => :get }

  map.resources :personas, :has_many => [:telefonos ]

  map.resources :profesors

  map.resources :familias, :member => { :agregar_alumnos => :get, :agregar_personas => :get }, :collection  => { :agregar_alumnos => :put, :agregar_personas => :put}
  map.resources :familias, :member => { :quitar_alumnos => :get, :quitar_personas => :get }
  map.resources :familias, :member => { :quitar_alumnos => :put, :quitar_personas => :put }

  map.resources :alumnos, :has_many => [:falta_de_asistencias]

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
