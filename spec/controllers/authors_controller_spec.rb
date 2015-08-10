require 'rails_helper'

RSpec.describe AuthorsController, :type => :controller do
  describe "GET #index" do
    it "returns a successful http request stutus code" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful http request status code" do
      author = Fabricate(:author)

      get :show, id: author.id
      expect(response).to have_http_status(:success)
    end
  end
end
