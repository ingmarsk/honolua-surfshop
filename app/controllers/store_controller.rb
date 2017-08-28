class StoreController < ApplicationController

	# Enables us to use @cart in the store layout from the StoreController
	include CurrentCart	

	# Whitelisting: mark following method as NOT required before actions for this controller
	skip_before_action :authorize

	before_action :set_cart

  def index
  	# Get all products from db ordered by title
  	@products = Product.order(:title)
  end

end
