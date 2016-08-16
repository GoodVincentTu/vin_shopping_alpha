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
		end
	end

	def create
		@order_form = OrderForm.new(
			user: User.new(order_params[:user]),
			cart: @cart
		)

		if @order_form.save
			notify_user
			if charge_user
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
		@order_form.user.send_reset_password_instructions
		OrderMailer.order_confirmation(@order_form.order).deliver_later
	end

	def notify_user_about_state
		OrderMailer.state_changed(@order, @previous_state).deliver_later
	end

	def order_params
		params.require(:order_form).permit(
			user: [ :first_name, :last_name, :email, :phone ]
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
end