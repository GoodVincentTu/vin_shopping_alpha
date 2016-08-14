json.extract! meta_item, :id, :name, :sku, :price, :created_at, :updated_at
json.url meta_item_url(meta_item, format: :json)