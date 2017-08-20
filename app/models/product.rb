class Product < ActiveRecord::Base

	has_many :line_items

	# Hook method called by Rails before attempting to destroy a row in the db.
	# If :ensure_not_referenced_by_any_line_item == false, do not destroy the line items row.
	before_destroy :ensure_not_referenced_by_any_line_item

	# Standard Rails validators

	# Check model fields against the condition 'presence = true'
	validates :title, :description, :image_url, presence: true

	# Validates that the price is a valid and positive number
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }

	# Checks each product has a unique title
	validates :title, uniqueness: true

	# Checks image URL ends with .gif, .jpg or .png
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a valid URL (gif, jpg or png)'
	}

	# Return the most recently updated product
	def self.latest
		Product.order(:updated_at).last
	end

	private

	# Checks that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items are present')
			return false
		end
	end

end
