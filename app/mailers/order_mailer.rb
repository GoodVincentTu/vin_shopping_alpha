class OrderMailer < ActionMailer::Base
	default from: 'happy_company@example.com'

	def order_confirmation order
		sleep 5
		@order = order
		mail to: order.user.email, subject: "Your order (##{order.id})"
	end

	def state_changed order, previous_state
		sleep 5
		@order = order
		@previous_state = previous_state

		mail to: order.user.email, subject: "Your order (##{order.id}) progress has changed !"
	end
end