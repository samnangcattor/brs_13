require "rails_helper"

RSpec.describe "reviews/show", type: :view do 
  before :each do
    @user = FactoryGirl.create :user
    @review = FactoryGirl.create :review
    @review.user_id = @user.id
    5.times do |n|
        FactoryGirl.create :comment, review_id: @review.id, user_id: @user.id
    end
     @comments = Comment.all.paginate page: params[:page], per_page: Settings.page_size
  end

  it "request to reviews controller and show action" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "reviews"
    expect(controller.request.path_parameters[:action]).to eq "show"
  end

  it "display the title of Review" do
    render
    expect(rendered).to include "Review"
  end

  it "display more information about review" do
    render
    expect(rendered).to include @review.user.name, @review.review
  end 
end
