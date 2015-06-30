FactoryGirl.define do
  name = Faker::Name.name
  email = Faker::Internet.email

  factory :user do
    name name
    email email
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
