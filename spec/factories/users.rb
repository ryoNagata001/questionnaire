FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password pass
    password_confirmation pass
    company
    initialize_with { User.find_or_create_by(email: email) }
    before(:create){ |user|
      # ここで認証済みでメールを送信しない設定を行う
      user.skip_confirmation_notification!
      user.skip_confirmation!

    }
  end
end
