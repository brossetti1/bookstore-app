require 'rails_helper'

RSpec.describe CatalogsController, :type => :controller do
  let(:book1) { Fabricate(:book) }
  let(:book2) { Fabricate(:book) }

  describe "GET #index" do
    it "returns a successful http request stutus code" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful http request status code" do
      get :show, id: book1
      expect(response).to have_http_status(:success)
    end
  end
  
end
