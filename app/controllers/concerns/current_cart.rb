module CurrentCart extend ActiveSupport::Concern

	private

	# Get the :cart_id from the session object and try to find a cart with this ID.
	# If no cart found, create a new one and store the cart ID into the current session.
	def set_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end

end