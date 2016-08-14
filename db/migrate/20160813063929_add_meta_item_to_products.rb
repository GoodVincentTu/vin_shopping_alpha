class AddMetaItemToProducts < ActiveRecord::Migration[5.0]
  def change
  	meta_item = MetaItem.create! name: "No Category", sku: "none", price: 0.0
    add_reference :products, :meta_item, foreign_key: true, default: meta_item.id
  end
end
