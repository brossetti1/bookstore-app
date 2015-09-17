class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    @cart_item = @cart.add_book_to_items(params[:book_id])
    if @cart_item
      redirect_to @cart_item.cart
    end
  end
  
end
