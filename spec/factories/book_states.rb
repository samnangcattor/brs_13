FactoryGirl.define do
  factory :book_state do
    book
    user
    state "unknow"
  end
end
