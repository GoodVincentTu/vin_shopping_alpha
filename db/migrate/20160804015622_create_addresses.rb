class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string  :address
      t.integer :zip_code
      t.string  :country
      t.string  :state
      t.string  :city
      t.boolean :default, default: true

      t.timestamps
    end
  end
end
