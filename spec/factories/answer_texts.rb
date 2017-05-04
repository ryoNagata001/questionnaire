FactoryGirl.define do
  factory :answer_text do
    association :question
    association :user
    content {Faker::Lorem.sentence}
  end
end
