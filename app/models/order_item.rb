class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # Todo - Need MetaItem model
  def total_price
  	# self.quantity * self.price
  end
end
