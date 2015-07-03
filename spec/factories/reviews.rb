FactoryGirl.define do
  factory :review do
    book
    user
    review "this is a review"
    rate 2
  end
end
