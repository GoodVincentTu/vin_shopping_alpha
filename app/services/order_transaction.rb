class OrderTransaction
	def initialize order, nonce
		@order = order
		@nonce = nonce
	end

	def execute
		@result = Braintree::Transaction.sale(
			# amount: order.total_price,
			amount: '30.00',
			payment_method_nonce: nonce
		)
	end

	def ok?
		@result.success?
	end

	private

	attr_reader :order, :nonce
end
