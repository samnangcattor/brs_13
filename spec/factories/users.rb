FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "example#{n}"}
    sequence(:email) {|n| "example#{n}@gmail.com"}
    role false
    password "123456"
    password_confirmation "123456"
  end

  factory :admin, class: User do
    name "A"
    email "a@gmail.com"
    role true
    password "123456"
    password_confirmation "123456"
  end
end
