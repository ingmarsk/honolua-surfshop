module ApplicationHelper

	# Helper method for hiding an Empty Cart
	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes["style"] = "display: none"
		end
		# Rails standard helper which wraps the output created by the block in a tag.
		# &block passes the block that was given to hidden_div_if to the content_tag().
		content_tag("div", attributes, &block)
	end

end
