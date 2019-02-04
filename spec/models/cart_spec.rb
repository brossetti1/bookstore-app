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

  it "should handle zero cart items" do
    cart = Fabricate(:cart)
    expect(cart.total_sale).to eq(0)
  end

  it "should convert total to integer version in cents" do
    book2 = Fabricate(:book, price: 15)
    cart = Fabricate(:cart)
    cart_item2 = Fabricate(:cart_item, cart_id: cart.id, book_id: book2.id,
                        price: book2.price, quantity: 1)

    cart.cart_items << cart_item2

    expect(cart.total_sale_in_cents).to eq(1500)
  end

  it '#remove_book_from_items' do
    book2 = Fabricate(:book, price: 15)
    cart = Fabricate(:cart)
    cart_item2 = Fabricate(:cart_item, cart_id: cart.id, book_id: book2.id,
                        price: book2.price, quantity: 1)

    cart.remove_book_from_items(book2.id)

    expect(cart.books).to_not include(book2)
  end

  context '#add_book_to_items' do
    it 'when cart item is null it sets cart items to 1' do
      book2 = Fabricate(:book, price: 15)
      cart  = Fabricate(:cart)

      expect(cart.cart_items.count).to eq(0)

      cart.add_book_to_items(book2.id)

      expect(cart.cart_items.count).to eq(1)
      expect(cart.cart_items.first.quantity).to eq(1)
    end

    it 'when cart item exists' do
      cart  = Fabricate(:cart)
      cart_item1 = Fabricate(:cart_item, cart_id: cart.id, quantity: 2)

      cart.cart_items << cart_item1

      book2 = cart_item1.book

      expect(cart.cart_items.first.quantity).to eq(2)

      cart.add_book_to_items(book2.id)

      expect(cart.cart_items.first.quantity).to eq(3)
    end
  end
end
