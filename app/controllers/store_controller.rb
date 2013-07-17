class StoreController < ApplicationController
  def index
  	@products = Product.order(:title) # orders all products by :title
  end
end
