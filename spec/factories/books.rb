FactoryGirl.define do
  date = Faker::Date.forward(23)

  factory :book do
    sequence(:title) {|n| "example#{n}"}
    publish_date date
    page 100
  end
end
