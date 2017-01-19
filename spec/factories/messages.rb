FactoryGirl.define do

  sample_time = Faker::Time.between(2.days.ago, Time.now, :all)

  factory :message do
    body                      { Faker::Lorem.words }
    image                     { Faker::File.file_name }
    chat_group_id             { Faker::Number.between }
    user_id                   { Faker::Number.between }
    created_at                sample_time
    updated_at                sample_time
  end
end
