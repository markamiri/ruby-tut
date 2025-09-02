class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.decimal :price, precision: 10, scale: 2
      t.datetime :uploaded_at
      t.integer :quantity
      t.string :condition
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
