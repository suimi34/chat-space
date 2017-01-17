FactoryGirl.define do

  sample_password = Faker::Internet.password(8)

  factory :user do
    name                      { Faker::Name.name }
    email                     { Faker::Internet.email }
    password                  sample_password
    password_confirmation     sample_password
  end
end
