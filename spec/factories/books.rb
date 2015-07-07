FactoryGirl.define do
  date = Faker::Date.forward(23)

  factory :book do
    sequence(:title) {|n| "example#{n}"}
    publish_date date
    page 100

    factory :author_of_book do
      author = FactoryGirl.create :author
      after :create do |book|
        create :author_book, book: book, author: author
      end
    end
  end
end
