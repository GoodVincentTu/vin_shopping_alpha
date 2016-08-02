class CreateImageGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :image_groups do |t|
      t.integer :product_id
      t.string :image

      t.timestamps
    end
  end
end
