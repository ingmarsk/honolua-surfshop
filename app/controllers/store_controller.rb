class StoreController < ApplicationController

	# Enables us to use @cart in the store layout from the StoreController
	include CurrentCart	
	before_action :set_cart

  def index
  	# Get all products from db ordered by title
  	@products = Product.order(:title)
  end

end
