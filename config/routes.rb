Rails.application.routes.draw do
  resources :pins
  #resources :products
  devise_for :users
  get "admin/index"
  
resources :products do
  member do
    delete :remove_image
    post :reorder_images
  end
end

  # Admin categories page 
  resources :categories
  
  #public facing categories page 
  get "/category/:slug", to: "category#show", as: :category_page 

  #public facing page for products 
  get "/product/:slug", to: "product#show", as: :product_page


  #get "home/index"

  #gets the about page
  get "home/about"

  get "/admin", to: "admin#index", as: :admin


  # Makes the home/index the home page of the website 
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
