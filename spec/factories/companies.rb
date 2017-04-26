FactoryGirl.define do
  factory :company do
    name {Faker:: Lorem.word}
    password {Faker::Internet.password(8)}
    chief_id {Faker::Number.between(1, 100)}
  end
end
