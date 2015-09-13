require 'rails_helper'
require 'support/macros'
require 'support/shared_examples'

RSpec.describe Admin::PublishersController, :type => :controller do
  let(:admin) { Fabricate(:admin) }

  before { set_current_admin admin }

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
    let(:publisher) { Fabricate(:publisher) }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :show, id: publisher }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { get :show, id: publisher }
      end
    end

    context "admin users" do
      it "returns a successful http request status code" do
        get :show, id: publisher
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, publisher: Fabricate.attributes_for(:publisher) }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { post :create, publisher: Fabricate.attributes_for(:publisher) }
      end
    end

    context "admin users" do
      context "a successful create" do
        before do
          post :create, publisher: Fabricate.attributes_for(:publisher)
        end

        it "saves the new publisher object" do
          expect(Publisher.count).to eq(1)
        end

        it "redirects to the show action" do
          expect(response).to redirect_to publisher_path(Publisher.first)
        end

        it "sets the success flash message" do
          post :create, publisher: Fabricate.attributes_for(:publisher)
          expect(flash[:success]).to eq('Publisher has been created.')
        end
      end

      context "unsuccessful create" do
        before do
          post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
        end

        it "it does not save the new publisher object with invalid inputs" do
          expect(Publisher.count).to eq(0)
        end

        it "renders to the new template" do
          expect(response).to render_template :new
        end

        it "sets the failure flash message" do
          expect(flash[:danger]).to eq('Publisher has not been created.')
        end
      end
    end
  end

  describe "GET #edit" do
    let(:publisher) { Fabricate(:publisher, name: 'John') }
    it "finds the publisher with the given id and assigns to @publisher variable" do
      get :edit, id: publisher
      expect(assigns(:publisher)).to eq(publisher)
    end

    it "renders the edit template" do
      get :edit, id: publisher
      expect(response).to render_template('edit')
    end
  end

  describe "PUT #update" do
    let(:publisher) { Fabricate(:publisher) }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { put :update, publisher: Fabricate.attributes_for(:publisher), id: publisher.id }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { put :update, publisher: Fabricate.attributes_for(:publisher), id: publisher.id }
      end
    end

    context "admin users" do
      context "a successful update" do
        before do
          put :update, publisher: Fabricate.attributes_for(:publisher, name: 'Paul'), id: publisher.id
        end
        it "updates the modified publisher object" do
          expect(Publisher.first.name).to eq('Paul')
        end

        it "redirects to the show action" do
          expect(response).to redirect_to publisher_path(Publisher.first)
        end

        it "sets the success flash message" do
          expect(flash[:success]).to eq('Publisher has been updated.')
        end
      end

      context "unsuccessful update" do
        let(:publisher) { Fabricate(:publisher, name: 'Paul') }
        before do
          put :update, publisher: Fabricate.attributes_for(:publisher, name: ''), id: publisher.id
        end

        it "does not update the modified publisher object" do
          expect(Publisher.first.name).to eq('Paul')
        end

        it "renders the edit template" do
          expect(response).to render_template :edit
        end

        it "sets the failure flash message" do
          expect(flash[:danger]).to eq('Publisher has not been updated.')
        end
      end #context
    end
  end

  describe 'DELETE #destroy' do
    let(:publisher) { Fabricate(:publisher, name: 'Paul') }

    context "guest users" do
      it_behaves_like "requires sign in" do
        let(:action) { delete :destroy, id: publisher }
      end
    end

    context "non-admin users" do
      it_behaves_like "requires admin" do
        let(:action) { delete :destroy, id: publisher }
      end
    end

    context "admin users" do
      before do
        delete :destroy, id: publisher
      end
      it 'deletes the publisher with the given id' do
        expect(Publisher.count).to eq(0)
      end

      it 'sets the flash message' do
        expect(flash[:success]).to eq('Publisher has been deleted.')
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to publishers_path
      end
    end
  end
end
