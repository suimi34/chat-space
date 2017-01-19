FactoryGirl.define do

  sample_password = Faker::Internet.password(8)

  factory :user do
    name                      { Faker::Name.name }
    email                     { Faker::Internet.email }
    password                  sample_password
    password_confirmation     sample_password
    after(:create) do |user|
      user.chat_groups << FactoryGirl.build(:chat_group, name: Faker::Lorem.words)
      user.chat_groups << FactoryGirl.build(:chat_group, name: Faker::Lorem.words)
    end
  end
end
