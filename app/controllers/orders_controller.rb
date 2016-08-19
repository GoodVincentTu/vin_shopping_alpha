class OrdersController < ApplicationController
	before_filter :initialize_cart

	def index
		@orders = Order.order(:created_at => :desc).all
	end

	def update
		@order = Order.find(params[:id])
		@previous_state = @order.state
		if @order.update state_order_params
			notify_user_about_state
			redirect_to orders_path, notice: "Order was updated."
		else
			redirect_to orders_path, alert: "The order state was not successfully updated."
		end
	end

	def create
		current_user.update(order_params[:user])
		@customer = current_user
		@order_form = OrderForm.new(
			user: @customer,
			cart: @cart
		)

		if @order_form.save
			notify_user
			@order = @order_form.order
			if charge_user || stripe_payment
				redirect_to root_path, notice: "Thank you for placing the order."
			else
				flash[:warning] = <<EOF
We have stored the order with the id of #{@order_form.order.id}.
You should receive an email with the order details and password change.<br/>
However, something went wrong with your credit card or paypal account, please try another one.
EOF
				redirect_to new_payment_order_path(@order_form.order)
			end
		else
			render 'carts/checkout'
		end
	end

	# for the action of the new_payment_order_path
	def new_payment
		@order = Order.find params[:id]
		@client_token = Braintree::ClientToken.generate
	end

	def pay
		@order = Order.find params[:id]
		transaction = OrderTransaction.new @order, params[:payment_method_nonce]
		transaction.execute
		if transaction.ok?
			redirect_to root_path, notice: "Thank you for placing the order."
		else
			render 'orders/new_payment'
		end
	end

	private

	def notify_user
		# @order_form.user.delay_for(5.seconds).send_reset_password_instructions
		OrderNotifyEmailWorker.perform_async @order_form.order.to_json
		# @order_form.user.send_reset_password_instructions
		# OrderMailer.order_confirmation(@order_form.order).deliver_later
	end

	def notify_user_about_state
		OrderNotifyEmailWorker.perform_async @order.to_json, @previous_state
		# OrderMailer.state_changed(@order, @previous_state).deliver_later
	end

	def order_params
		params.require(:order_form).permit(
			user: [ :first_name, :last_name, :email, :phone, :address, :country, :state, :city, :zip_code ]
		)
	end

	def charge_user
		transaction = OrderTransaction.new @order, params[:payment_method_nonce]
		transaction.execute
		transaction.ok?
	end

	def state_order_params
		params.require(:order).permit(:state)
	end

	def stripe_payment
		stripe_transaction = StripeTransaction.new @order, stripe_params["stripeEmail"], stripe_params["stripeToken"]
		stripe_transaction.execute
		stripe_transaction.ok?
	end

	def stripe_params
		params.permit :stripeEmail, :stripeToken
	end
end