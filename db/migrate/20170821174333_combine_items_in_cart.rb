class CombineItemsInCart < ActiveRecord::Migration

  def up
  	# Iterate over each cart in the db
  	Cart.all.each do |cart|
  		# For each cart, get a sum of the quantity fields for each of the line items from the cart, grouped by product_id
  		# Save the resulting sums in the sums list
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		# Iterate over each sum extracting the product_id and quantity
  		sums.each do |product_id, quantity|
  			# In case there are duplicates (quantity > 1)
  			if quantity > 1
  				# Delete all of the line items associated with the cart and the product
  				cart.line_items.where(product_id: product_id).delete_all

  				# Replace the deleted items with a new item
  				item = cart.line_items.build(product_id: product_id)

  				# Set the correct quantity to the new item
  				item.quantity = quantity

  				# Save the item to db
  				item.save!
  			end
  		end
  	end
  end

end
