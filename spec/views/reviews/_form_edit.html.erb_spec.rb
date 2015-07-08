require "rails_helper"

RSpec.describe "reviews/_form_edit", type: :view do 
  before {@review = FactoryGirl.create :review}

  it "request to reviews controller and create action" do
    render "reviews/form_edit"

    expect(controller.request.path_parameters[:controller]).to eq "reviews"
  end
end
