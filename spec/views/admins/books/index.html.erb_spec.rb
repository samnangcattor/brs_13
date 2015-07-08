require "rails_helper"

RSpec.describe "admins/books/index", type: :view do  
  before do
    5.times do
      FactoryGirl.create :book
    end
    @books = Book.paginate page: params[:page], per_page: Settings.page_size
  end

  it "require to books controller with action index" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "admins/books"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "display informatioin of each books" do
    render
    expect(rendered).to include "Titles", "Books",
     "Publish Date", "Categories", "Authors", "Edit/Delete"
  end
end
