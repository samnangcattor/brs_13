require "rails_helper"

RSpec.describe "admins/books/category", type: :view do
  before {@category = FactoryGirl.create :category}

  it "display _category partials" do
    render "admins/books/category", category: @category
    expect(rendered).to include @category.name
  end
end
