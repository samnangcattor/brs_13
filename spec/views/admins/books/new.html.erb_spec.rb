require "rails_helper"

RSpec.describe "admins/books/new" do
  let(:category) {FactoryGirl.create :category}

  before do
    @book = FactoryGirl.create :book
    5.times do
      FactoryGirl.create :author
      FactoryGirl.create :category
    end
    @authors = Author.all
    @categories = Category.all
  end

  it "require to book controller to new action" do
    render
  end

  it "display title of menu  add book" do
    render
    expect(rendered).to include "Add new books"
  end
end
