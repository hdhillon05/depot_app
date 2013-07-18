module CurrentCart # this allows us to share common code between controllers and also prevents rails from ever making it available as an action in a controller
  extend ActiveSupport::Concern

  private
    def set_cart
      @cart = Cart.find(session[:cart_id]) #get card id from session object
    rescue ActiveRecord::RecordNotFound #if card not found, then store id of a new created cart into session and then return the new cart
      @cart = Cart.create
      session[:cart_id] = @cart.id 
    end
end