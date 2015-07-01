FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "example#{n}"}
    sequence(:email) {|n| "example#{n}@gmail.com"}
    role false
    password "123456"
    password_confirmation "123456"

    factory :user_activity do
      after :create do |user|
        create :activity, user: user
      end
    end

    factory :mark_book_favorite do
      book = FactoryGirl.create :book
      after :create do |user|
        create :book_favorite, user: user, book: book
      end
    end

    factory :mark_book_state do
      book = FactoryGirl.create :book
      after :create do |user|
        create :book_state, book: book, user: user
      end
    end
  end

  factory :admin, class: User do
    name "A"
    email "a@gmail.com"
    role true
    password "123456"
    password_confirmation "123456"
  end
end
