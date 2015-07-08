require "rails_helper"

RSpec.describe "admins/books/book", type: :view do
  before do 
    @book = FactoryGirl.create :book
  end

  it "display _category partials" do
    render "admins/books/book", book: @book
    expect(rendered).to include @book.title, "Edit", "Delete"
  end
end
