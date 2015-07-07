FactoryGirl.define do
  factory :author do
    sequence(:name) {|n| "example#{n}"}
  end
end
