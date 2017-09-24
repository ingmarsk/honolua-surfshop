module ProductsHelper
	def can_edit_product?(current_user, product)
    current_seller = Seller.find_by(user_id: current_user.id)
    current_seller.user_id == product.seller_id if current_seller
  end
end
