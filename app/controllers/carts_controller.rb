class CartsController < ApplicationController
  before_action :set_cart

  def show
    # @cart is set by set_cart
  end

  def add_item
    product = Product.find(params[:product_id])
    # Check if item already in cart
    cart_item = @cart.cart_items.find_by(product_id: product.id)
    
    if cart_item
      cart_item.quantity += 1
    else
      cart_item = @cart.cart_items.build(product: product, quantity: 1)
    end
    
    cart_item.save
    redirect_to cart_path
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = find_or_create_cart
  end

  def find_or_create_cart
    if user_signed_in?
      # cart belongs to user if logged in
      current_user.cart ||= Cart.create(user: current_user)
    else
      # session-based cart if not logged in
      Cart.find(session[:cart_id]) rescue create_session_cart
    end
  end

  def create_session_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end

