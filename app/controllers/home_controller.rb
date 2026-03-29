class HomeController < ApplicationController
  def index
        @latest_products = Product.with_attached_images.order(created_at: :desc).limit(10)
        @best_products = Product.with_attached_images.best.order(created_at: :desc).limit(5)
        @featured_products = Product.with_attached_images.featured.order(created_at: :desc).limit(5)
        @categories = Category.with_attached_image.all

  end

  def about 
  end
end
