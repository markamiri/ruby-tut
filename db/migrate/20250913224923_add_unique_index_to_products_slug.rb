class AddUniqueIndexToProductsSlug < ActiveRecord::Migration[8.0]
  def change
    add_index :products, :slug, unique: true
    change_column_null :products, :slug, false
  end
end
