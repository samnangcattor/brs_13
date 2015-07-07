require "rails_helper"

RSpec.describe "reviews/form_modal", type: :view do
  before {@review = FactoryGirl.create :review}

  it "display a _formdal parial" do
    render "reviews/form_modal", review: @review
    expect(rendered).to match /Edit review/
  end
end
