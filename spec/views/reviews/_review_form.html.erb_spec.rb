require "rails_helper"

RSpec.describe "reviews/review_form", type: :view do
  before do
    @review = FactoryGirl.build :review
    @book = FactoryGirl.create :book
  end

  it "display the _review_form partial" do
    render "reviews/review_form", book: @book

    expect(rendered).to match /Compose new review/
  end
end
