class Cart < ActiveRecord::Base
	# If a cart is destroyed (its record in db is deleted, Rails deletes any line items that are associated with that cart
	has_many :line_items, dependent: :destroy

	# Checks if list items includes current product we're adding. 
	# If it does increments the quantity If it doesn't it builds a new LineItem.
	def add_product(product_id)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
		end
			current_item
	end

	# Sum the prices of each item in the collection
	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

end
