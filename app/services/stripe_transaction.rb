class StripeTransaction
	def initialize order, email, token
		@order = order
		@email = email
		@token = token
	end

	def execute
		customer = Stripe::Customer.create email: @email,
		 																	 card:  @token

		@result = Stripe::Charge.create(
			amount: 2000,
			currency: 'usd',
			source: @token,
			description: 'The products of your order!'
		)
	end

	def ok?
		@result.paid?
	end
end
