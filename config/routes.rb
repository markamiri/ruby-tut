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

  get "up" => "rails/health#show", as: :rails_health_check


  #logo 
  resource :logo

  resources :slide_shows, only: [:new, :create, :destroy] do
  member do
    delete :remove_image
  end

  collection do
    post :reorder
  end
end

 
end
