class Cart < ActiveRecord::Base
	# If a cart is destroyed (its record in db is deleted, Rails deletes any line items that are associated with that cart.
	has_many :line_items, dependent: :destroy
end
