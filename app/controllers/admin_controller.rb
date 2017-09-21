class AdminController < ApplicationController

	before_action :require_admin

  def index
  	@total_users = User.count
  	@total_orders = Order.count
  	@total_products = Product.count
  end
end
