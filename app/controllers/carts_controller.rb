class CartsController < ApplicationController
	before_filter :initialize_cart

	def add
		@cart.add_item params[:id]
		session["cart"] = @cart.serialize
		product = Product.find params[:id]
		redirect_to :back, notice: "Added #{product.name} to cart."
	end

	def show
	end

	def checkout
		if current_user
			@order_form = OrderForm.new user: current_user
			@client_token = Braintree::ClientToken.generate
		else
			redirect_to new_user_session_url
		end
	end

	# def destroy
	# end
end