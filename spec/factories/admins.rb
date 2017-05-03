FactoryGirl.define do
  factory :admin do
    email {Faker::Internet.email}
    name {Faker::Name.last_name}
    password {Faker::Internet.password(6)}

    factory :same_email_admin do
      email 'hoge@hoge.hoge'
    end
    factory :too_long_name_admin do
      name 'hogehogehogehogehogehoge'
    end
  end
end
