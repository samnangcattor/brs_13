require "rails_helper"

RSpec.describe "admins/books/edit", type: :view do
  let(:author) {FactoryGirl.create :author}

  before do
    @book = FactoryGirl.create :book
    5.times do
      FactoryGirl.create :category
      FactoryGirl.create :author
    end
    @categories = Category.all
    @authors = Author.all

    it "require to books controller with actioin" do
      render
      expect(controller.request.path_parameters[:controller]).to eq "amdins/books"
      expect(controller.request.path_parameters[:action]).to eq "edit"
    end

    it "display title of page edit book" do
      render
      expect(rendered).to include "Edit Book"
    end
  end
end
