FactoryGirl.define do
  factory :choice do
    association :question
    content {Faker::Lorem.sentence}
  end
end
