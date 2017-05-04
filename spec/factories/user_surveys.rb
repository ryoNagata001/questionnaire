FactoryGirl.define do
  factory :user_survey do
    association :survey
    association :user
    question_number 0

    factory :answered_user_survey do
      question_number 1
    end
  end
end
