class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_meta_items

  def initialize_cart
  	@cart = Cart.build_from_hash session
  end

  def find_meta_items
  	@meta_items = MetaItem.all
  end

  def authenticate_admin!
  	authenticate_user!

  	unless current_user.admin?
  		redirect_to root_path, alert: "You are not allowed to do this operation!"
  	end
  end
end
