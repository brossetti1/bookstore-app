require 'rails_helper'
require 'support/macros'
require 'support/shared_examples'

RSpec.describe Admin::AuthorsController, :type => :controller do
  let(:admin) { Fabricate(:admin) }

  before { set_current_admin admin }

  describe "GET #index" do
    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { get :index }
      end
    end

    context "admin users" do
      it "returns a successful http request stutus code" do
        get :index

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    let(:author) { Fabricate(:author) }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { get :index }
      end
    end

    context "admin users" do
      it "returns a successful http request status code" do
        get :show, id: author.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #new" do
    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { get :new }
      end
    end

    context "admin users" do
      it "returns a successful http request status code" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, author: Fabricate.attributes_for(:author) }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { post :create, author: Fabricate.attributes_for(:author) }
      end
    end

    context "admin users" do
      context "a successful create" do
        it "saves the new author object" do
          post :create, author: Fabricate.attributes_for(:author)

          expect(Author.count).to eq(1)
        end

        it "redirects to the author show action" do
          post :create, author: Fabricate.attributes_for(:author)

          expect(response).to redirect_to admin_author_path(Author.last)
        end

        it "sets the success flash message" do
          post :create, author: Fabricate.attributes_for(:author)

          expect(flash[:success]).to eq("Author has been created")
        end
      end

      context "an unsuccessful create" do
        it "does not save the author object with invalid inputs" do
          post :create, author: Fabricate.attributes_for(:author, first_name: nil)

          expect(Author.count).to eq(0)
        end

        it "sets the failure flash message" do
          post :create, author: Fabricate.attributes_for(:author, first_name: nil)

          expect(flash[:danger]).to eq("Author has not been created")
        end
      end
    end
  end

  describe "GET #edit" do
    let(:author) { Fabricate(:author) }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :edit, id: author }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { get :edit, id: author }
      end
    end

    context "admin users" do
      it "sends a successful edit request" do
        get :edit, id: author

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    let(:john) { Fabricate(:author, first_name: "John") }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { put :update, author: Fabricate.attributes_for(:author), id: john.id }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { put :update, author: Fabricate.attributes_for(:author), id: john.id }
      end
    end

    context "admin users" do
      context "successful update" do
        it "updates the modified author object" do
          put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id

          expect(Author.last.first_name).to eq("Mike")
          expect(Author.last.first_name).not_to eq("John")
        end

        it "sets the success flash message" do
          put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id

          expect(flash[:success]).to eq("Author has been updated")
        end

        it "it redirects to the show action" do
          put :update, author: Fabricate.attributes_for(:author, first_name: "Mike"), id: john.id

          expect(response).to redirect_to(admin_author_path(Author.last))
        end
      end

      context "unsuccessful update" do
        it "does not update the author object with invalid inputs" do
          put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id

          expect(Author.last.first_name).to eq("John")
        end

        it "sets the failure flash message" do
          put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id

          expect(flash[:danger]).to eq("Author has not been updated")
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:author) { Fabricate(:author) }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { delete :destroy, id: author.id }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { delete :destroy, id: author.id }
      end
    end

    context "admin users" do
      before do
        delete :destroy, id: author.id
      end

      it "deletes the author with the given id" do
        expect(Author.count).to eq(0)
      end

      it "sets the flash message" do
        expect(flash[:success]).to eq("Author has been deleted")
      end

      it "redirects to the index action" do
        expect(response).to redirect_to admin_authors_path
      end
    end
  end
end
