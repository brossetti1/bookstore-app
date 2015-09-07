require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let!(:user) { Fabricate(:user) }

  describe "GET #new" do
    context "unauthenticated users" do
      it "returns a successful http request status code" do
        get :new

        expect(response).to have_http_status(:success)
      end
    end

    context "authenticated users" do
      it "redirects to the root path" do
        session[:user_id] = user.id

        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    context "successful sign in" do
      before do
        post :create, { email: user.email, password: user.password }
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets the success flash message" do
        expect(flash[:success]).to eq('Sign in successful')
      end

      it "creates a session record for valid inputs" do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "unsuccessful sign in" do
      it "set the flash danger message" do
        post :create, { email: user.email, password: 'mypassword' }
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:user_id] = user.id

      delete :destroy, id: user.id
    end

    it "logs the user out" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end
