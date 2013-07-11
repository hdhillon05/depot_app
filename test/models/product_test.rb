require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products #name of fixture file determines the table that is loaded, so using :products will cause the products.yml fixture file to be loaded
	test "product attributes must not be empty" do
		product = Product.new
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be >=0.01" do 
		product = Product.new(title: "My Book Title", 
							  description: "yyy"
							  image_url: "zzz.jpg")
		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], products.errors[:price]
		
		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], products.errors[:price]
	
		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
	end

	test "image_url" to
		ok= %w{ fred.gif fred.jgp fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
		bad= %w{ fred.doc fred.gif/more fred.gif.more}

		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end

	test "product is not valid without a unique title" do 
		product = Product.new(title: products(:ruby).title, decription: "yyy", price: 1, image_url: "fred.gif")
		assert product.invalid?
		assert_equal ["has already been taken"], product.erros[:title]
	end

end