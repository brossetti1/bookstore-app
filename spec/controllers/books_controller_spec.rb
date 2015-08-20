require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  describe "GET #index" do
    it "returns a successful http request stutus code" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful http request status code" do
      book = Fabricate(:book)

      get :show, id: book
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns a successful http request status code" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "a successful create" do
      before do
        post :create, book: Fabricate.attributes_for(:book)
      end

      it "saves the new book object" do
        expect(Book.count).to eq(1)
      end

      it "redirects to the show action" do
        expect(response).to redirect_to book_path(Book.first)
      end

      it "sets the success flash message" do
        expect(flash[:success]).to eq('Book has been created')
      end
    end

    context "unsuccessful create" do
      before do
        post :create, book: Fabricate.attributes_for(:book, title: nil)
      end

      it "it does not save the new book object with invalid inputs" do
        expect(Book.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets the failure flash message" do
        expect(flash[:danger]).to eq('Book has not been created')
      end
    end
  end

  describe "GET #edit" do
    let(:book) { Fabricate(:book) }

    it "sends a successful edit request" do
      get :edit, id: book

      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    let(:book) { Fabricate(:book, title: 'Awesome title') }

    context "a successful update" do
      before do
        put :update, book: Fabricate.attributes_for(:book, title: 'Updated title'), id: book.id
      end

      it "updates the modified book object" do
        expect(Book.first.title).to eq('Updated title')
        expect(Book.first.title).not_to eq('Awesome title')
      end

      it "redirects to the show action" do
        expect(response).to redirect_to book_path(Book.first)
      end

      it "sets the success flash message" do
        expect(flash[:success]).to eq('Book has been updated')
      end
    end

    context "unsuccessful update" do
      before do
        put :update, book: Fabricate.attributes_for(:book, title: ''), id: book.id
      end

      it "does not update the modified book object" do
        expect(Book.first.title).to eq('Awesome title')
      end

      it "sets the failure flash message" do
        expect(flash[:danger]).to eq('Book has not been updated')
      end
    end #context
  end

  describe 'DELETE #destroy' do
    let(:book) { Fabricate(:book) }

    before do
      delete :destroy, id: book
    end

    it 'deletes the book with the given id' do
      expect(Book.count).to eq(0)
    end

    it 'sets the flash message' do
      expect(flash[:success]).to eq('Book has been deleted')
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to books_path
    end
  end

end
