require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  # Loads the fixture data for Product model into the products table before each test method is run
  fixtures :products

  test "the truth" do
  	# Method assert(). It expects its argument to be true
    assert 4 > 2
  end

  test "product is not valid without a unique title" do
    product = Product.new(
      title: products(:wax).title,
      description: "blblbl",
      image_url: "blbl.png",
      price: 4.99)

    assert product.invalid?
    assert_equal ["name has already been taken"], product.errors[:title]
  end

  test "product attributes must not be empty" do
  	product = Product.new   										# Creates a new product without fields (should be an invalid input!)
  	assert product.invalid?							  			# Returns true if errors were added, false otherwise.
  	assert product.errors[:title].any?					# Returns true if any errors
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url]
  end

  test "product price must be positive" do
  	product = Product.new(title: "A Product", description: "Lorem Ipsum", image_url: "img.jpg")

  	product.price = -1
  	assert product.invalid?  			# Returns true if erros. Because we set an invalid price it returns true so the assertion is true

  	product.price = 0
  	assert product.invalid?  			# price = 0 rises error
  	assert_equal ["must be greater than or equal to 0.01"], product.errors[:price] 	# Checks error message is the given string

  	product.price = 1
  	assert product.valid?   			# price = 1 is valid so assertion is true
	end

	def new_product(image_url)
		Product.new(title: "Another Product", description: "Blablabla", image_url: image_url, price: 1.99)
	end

	test "image url" do
		# Set string of urls to test
		valid_url = %w{ foo.jpg foo.png foo.gif FOO.JPG FOO.PNG FOO.GIF http://some_domain/some_path/foo.jpg }
		invalid_url = %w{ foo.pdf foo.gif/x foo.jpg.x }

		valid_url.each do |img_url|
			assert new_product(img_url).valid?, "#{img_url} should be valid"
		end

		invalid_url.each do |img_url|
			assert new_product(img_url).invalid?, "#{img_url} shouldn't be valid"
		end
	end

end
