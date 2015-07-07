require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  before :each do
    @user = FactoryGirl.create :user
    @review = FactoryGirl.create :review
    @review.user_id = @user.id
    @review.save
    sign_in :user, @user
  end

  describe "Get #show" do
    it "should response to User sign in page if user not sign in" do
      sign_out :user
      get :show, id: @review.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should response to show a review if signed in" do
      get :show, id: @review.id
      expect(response).to render_template "show"
    end
  end

  describe "Post #create" do
    before {@book = FactoryGirl.create :book}

    it "should response to User sign in page if user not sign in" do
      sign_out :user
      post :create
      expect(response).to redirect_to new_user_session_path
    end

    it "should response to create a review if user signed in" do
      post :create, book_id: @book.id, user_id: @user.id,
        review: @review.attributes.except("id")
      expect(response).to redirect_to request.referer || root_url
    end
  end

  describe "Get #edit" do
    it "should response to User sign in page if user not sign in" do
      sign_out :user
      get :edit, id: @review.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should response to edit a review if user signed in" do
      xhr :get, :edit, id: @review.id
      expect(response).to render_template "edit"
    end
  end

  describe "Patch #update" do
    before {@book = FactoryGirl.create :book}
  
    it "should response to user sign in page if user not sign in" do
      sign_out :user
      patch :update, id: @review.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should response to show all review when update success", js: true do
      patch :update, review: @review.attributes.except("id"),
        book_id: @book.id, user_id: @user.id
      expect(response).to redirect_to @review.book
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE #destroy" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :user
      delete :destroy, id: @review.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should response to show all book after delete success" do
      delete :destroy, id: @review.id
      expect(response).to redirect_to request.referer || root_url
      expect(flash[:success]).to be_present
    end
  end
end
