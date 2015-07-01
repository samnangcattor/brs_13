FactoryGirl.define do
  factory :activity do
    user
    target_id 0
    state_target "unknow"
  end
end
