class StripeTransaction
	def initialize order, email, token
		@order = order
		@email = email
		@token = token
	end

	def execute
		customer = Stripe::Customer.create email: email, card: token
		customer.sources.create(:source => token)

		@result = Stripe::Charge.create(
			customer: customer.id,
			amount: @order.total_price.to_i * 100,
			currency: 'usd',
			# source: @token,
			description: 'The products of your order!'
		)
	end

	def ok?
		@result.paid?
	end

	private

	attr_reader :email, :order, :token
end
