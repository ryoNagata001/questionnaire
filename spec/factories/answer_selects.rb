FactoryGirl.define do
  factory :answer_select do
    association :choice
    association :user
  end
end
