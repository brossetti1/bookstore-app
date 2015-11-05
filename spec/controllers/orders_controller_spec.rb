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
end
