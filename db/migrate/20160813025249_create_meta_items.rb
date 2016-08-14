class CreateMetaItems < ActiveRecord::Migration[5.0]
  def change
    create_table :meta_items do |t|
      t.string  :name
      t.string  :sku
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0,  :null => false

      t.timestamps
    end
  end
end
