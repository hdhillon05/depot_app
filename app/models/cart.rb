class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
    # cart potentially has many line items
    # dependent: :destroy -- existence of line items is dependent on existence of the cart. if we delete cart, delete want rails to delete any line items associated with the cart
  
end
