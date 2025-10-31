class AddProductsCountToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :products_count, :integer, null: false, default: 0 
    add_index  :categories, :products_count

  end
end
