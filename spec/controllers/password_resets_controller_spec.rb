require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do
  let(:john) { Fabricate(:user) }

  describe "GET #new" do
    it "returns a successful http request status code" do
        get :new

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "no email address filled in" do
      it "redirects to the reset password page" do
        post :create, email: ""
        expect(response).to redirect_to reset_password_path
      end

      it "displays the danger error message" do
        post :create, email: nil
        expect(flash[:danger]).to eq("Email can't be blank.")
      end
    end

    context "invalid email address filled in" do
      it "redirects to the reset password page" do
        post :create, email: "test@example.com"
        expect(response).to redirect_to reset_password_path
      end

      it "displays error message" do
        post :create, email: "test@example.com"
        expect(flash[:danger]).to eq("Email invalid.")
      end
    end

    context "valid email address filled in"
      it "redirects to the reset password page" do
        post :create, email: john.email
        expect(response).to render_template :confirm_password_reset
      end

      it "should send an email to user email address" do
        post :create, email: john.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([john.email])
      end
  end
end
