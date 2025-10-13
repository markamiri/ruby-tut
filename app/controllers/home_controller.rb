class HomeController < ApplicationController
  def index
        @latest_products = Product.order(created_at: :desc).limit(10)
        @best_products = Product.best.order(created_at: :desc).limit(5)
        @featured_products = Product.featured.order(created_at: :desc).limit(5)

  end

  def about 
  end
end
