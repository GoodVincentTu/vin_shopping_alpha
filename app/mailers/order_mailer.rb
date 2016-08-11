class OrderMailer < ActionMailer::Base
	default from: 'happy_company@example.com'

	def order_confirmation order
		@order = order
		mail to: order.user.email, subject: "Your order (##{order.id})"
	end
end