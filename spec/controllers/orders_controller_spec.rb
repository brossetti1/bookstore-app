require 'rails_helper'
require 'support/macros'

RSpec.describe OrdersController, :type => :controller do
  let(:john) { Fabricate(:user) }
  before { set_current_user(john) }

  describe "GET #new" do
	  it "returns a successful http request status code" do
      get :new

      expect(response).to have_http_status(:success)
    end

    it "redirects to the signin page for unauthenticated users" do
      clear_current_user

      get :new
      expect(response).to redirect_to(signin_path)
    end
  end

  describe "POST #create" do
    let(:cart) { Fabricate(:cart) }
    let!(:book) { Fabricate(:book) }
    let!(:cart_item) { Fabricate(:cart_item, cart: cart, book: book) }
    let!(:cart_items) { cart.cart_items << cart_item }

    let(:token) do
      Stripe::Token.create(
        :card => {
        :number => '4242424242424242',
        :exp_month => 10,
        :exp_year => 2016,
        :cvc => 314
        }
      ).id
    end

    before do
      set_current_cart(cart)
    end

    it "saves the new order object" do
      post :create, order: Fabricate.attributes_for(:order, user: john), stripeToken: token
      expect(Order.count).to eq(1)
    end

    it "sets the success flash message" do
      post :create, order: Fabricate.attributes_for(:order, user: john), stripeToken: token
      expect(flash[:success]).to eq('Order has been created')
    end

    it "should send an email to the user email address" do
      ActionMailer::Base.deliveries = []

      post :create, order: Fabricate.attributes_for(:order, user: john), stripeToken: token
      expect(ActionMailer::Base.deliveries.last.to).to eq([john.email])
    end
  end


end
