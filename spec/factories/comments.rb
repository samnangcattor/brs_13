FactoryGirl.define do
  factory :comment do 
    user
    review
    comment "this is comment"
  end
end
