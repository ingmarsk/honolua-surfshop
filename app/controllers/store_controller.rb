class StoreController < ApplicationController
  def index
  	# Get all products from db ordered by title
  	@products = Product.order(:title)
  end
end
