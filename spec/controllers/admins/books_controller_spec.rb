require "rails_helper"

RSpec.describe Admins::BooksController, type: :controller do
  before :each do
    @admin_user = FactoryGirl.create :user, role: :admin
    @book = FactoryGirl.build :book
    sign_in :admin, @admin_user
  end

  describe "Get #index" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      get :index
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show all books if Admin signed in" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "Get #show" do
    before {@book.save}

    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      get :show, admin_id: @admin_user.id, id: @book.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show a book if Admin signed it" do
      get :show, admin_id: @admin_user.id, id: @book.id
      expect(response).to render_template "show"
    end
  end

  describe "Get #new" do
    before :each do
      @category = FactoryGirl.build :category
      @author = FactoryGirl.build :author
    end

    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      get :new
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to have a new book if Admin signed it" do
      get :new
      expect(response).to render_template "new"
    end
  end

  describe "Post #create" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      get :create, admin_id: @admin_user.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to book index after save is success" do
      post :create, admin_id: @admin_user.id,
        book: @book.attributes.except("id")
      expect(response).to redirect_to admins_books_path
      expect(flash[:success]).to be_present
    end
  end

  describe "Get #edit" do
    before {@book.save}

    it "should response to Admin sign in page if user not sign it" do
      sign_out :admin
      get :edit, admin_id: @admin_user.id, id: @book.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response fill for update book information" do
      get :edit, admin_id: @admin_user.id, id: @book.id
      expect(response).to render_template "edit"
    end
  end

  describe "Patch #update" do
    before {@book.save}

    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      patch :update, admin_id: @admin_user.id, id: @book.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show all book when update success" do
      patch :update, admin_id: @admin_user.id, id: @book.id,
        book: @book.attributes.except("id")
      expect(response).to redirect_to admins_books_path
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE #destroy" do
    before {@book.save}

    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      delete :destroy, admin_id: @admin_user.id, id: @book.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show all book after delete success" do
      delete :destroy, admin_id: @admin_user.id, id: @book.id
      expect(response).to redirect_to request.referer || root_url
      expect(flash[:success]).to be_present
    end
  end
end
