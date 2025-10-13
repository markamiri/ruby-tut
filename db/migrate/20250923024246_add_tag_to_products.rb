class AddTagToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :tag, :integer
  end
end
