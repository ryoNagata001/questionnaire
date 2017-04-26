FactoryGirl.define do
  factory :question do
    title {Faker::Lorem.word}
    category_id 1
    association :survey

    factory :select_question do
      category_id 2
    end

  end
 end
