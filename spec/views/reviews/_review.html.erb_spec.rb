require "rails_helper"

RSpec.describe "reviews/_review", type: :view do
  before {@review = FactoryGirl.create :review}

  it "display the _review partial" do
    render "reviews/review", review: @review
    
    expect(rendered).to include @review.user.name, @review.review
  end
end
