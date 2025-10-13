class CategoryController < ApplicationController 
    def show 
        Rails.logger.debug "PARAMS: #{params.inspect}"   # 👈 add this

        @category = Category.find_by!(slug: params[:slug])
        @products = @category.products 
    end 
end 