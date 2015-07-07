FactoryGirl.define do
  factory :review do
    book
    user
    review "this is a review"
    rate 2

    factory :comment_on_review do
      after :create do |review|
        create :comment, user: review.user, review: review
      end
    end
  end
end
