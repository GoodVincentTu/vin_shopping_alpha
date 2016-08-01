class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
