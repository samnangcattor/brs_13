require "rails_helper"

RSpec.describe "admins/books/form", type: :view do
  let(:author)  {FactoryGirl.create :author}

  before do
    @book = FactoryGirl.create :book
    5.times do
      FactoryGirl.create :category
      FactoryGirl.create :author
    end
    @categories = Category.all
    @authors = Author.all
  end

  it "display _form parial render" do
    render "admins/books/form"
    expect(rendered).to include "Update"
  end
end
