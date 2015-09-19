require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:cart_items) }
  it { should have_many(:books).through(:cart_items) }

  describe "#total_sale" do
    it "should return the total sale amount for the cart" do
      book1 = Fabricate(:book, price: 10)
      book2 = Fabricate(:book, price: 15)

      cart = Fabricate(:cart)
      cart_item1 = Fabricate(:cart_item, cart_id: cart.id, book_id: book1.id,
                              price: book1.price, quantity: 2)
      cart_item2 = Fabricate(:cart_item, cart_id: cart.id, book_id: book2.id,
                              price: book2.price, quantity: 1)
      cart.cart_items << cart_item1
      cart.cart_items << cart_item2

      expect(cart.total_sale).to eq(35)
    end
  end
end
