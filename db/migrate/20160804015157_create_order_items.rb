class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
    	t.integer    :quantity
    	t.decimal    :price,   :precision => 8, :scale => 2
      t.references :order,   foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
