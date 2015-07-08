require "rails_helper"

RSpec.describe "admins/books/author", type: :view do
  before {@author = FactoryGirl.create :author}

  it "display _category partials" do
    render "admins/books/author", author: @author
    expect(rendered).to include @author.name
  end
end
