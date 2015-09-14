require "rails_helper"

RSpec.describe CartsController, :type => :controller do
  describe "GET #show" do
    let(:cart) { Fabricate(:cart) }

    it "returns a successful http request status code" do
      get :show, id: cart
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    let(:cart) { Fabricate(:cart) }

    it "sets cart session to nil" do
      delete :destroy, id: cart
      expect(session[:cart_id]).to be_nil
    end
  end
end
