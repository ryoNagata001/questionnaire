FactoryGirl.define do
  factory :survey do
    title {Faker::Lorem.word}
    released {Faker::Boolean.boolean}
    description {Faker::Lorem.sentence}
    association :company

    factory :survey_does_not_have_company do
      company_id nil
    end
  end
end
