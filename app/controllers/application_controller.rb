class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def initialize_cart
  	@cart = Cart.build_from_hash session
  end
end
