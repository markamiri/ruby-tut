json.extract! product, :id, :name, :slug, :price, :uploaded_at, :quantity, :condition, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
