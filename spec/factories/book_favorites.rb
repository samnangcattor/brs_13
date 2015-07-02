FactoryGirl.define do
  factory :book_favorite do
    user
    book
    favorite true
  end
end
