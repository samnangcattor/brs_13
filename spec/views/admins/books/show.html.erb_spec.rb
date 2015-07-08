require "rails_helper"

RSpec.describe "admins/books/show", type: :view do  
  let(:author)  {FactoryGirl.create :author}
  
  before do
    @book = FactoryGirl.create :book
    5.times do
      FactoryGirl.create :category
      FactoryGirl.create :author
      FactoryGirl.create :review
    end
    @categories = Category.all
    @authors = Author.all
    @reviews = Review.paginate page: params[:page], per_page: Settings.page_size
  end

  it "request to books controller and show action" do
    render 
    expect(controller.request.path_parameters[:controller]).to eq "admins/books"
    expect(controller.request.path_parameters[:action]).to eq "show"
  end

  it "display the information of Book" do
    render
    expect(rendered).to include @book.title
  end
end
