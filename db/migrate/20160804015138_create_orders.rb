class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
    	t.string     :email,   null: false, default: ""
    	t.boolean    :active,  default: false
    	t.boolean    :shipped, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
