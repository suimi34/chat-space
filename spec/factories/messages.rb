FactoryBot.define do

  sample_time = Faker::Time.between(from: 2.days.ago, to: Time.now)

  factory :message do
    body                      { Faker::Lorem.word }
    image                     { Faker::File.file_name }
    chat_group                { association(:chat_group) }
    user                      { association(:user) }
    created_at                { sample_time }
    updated_at                { sample_time }

    trait :as_invalid_input do
      body { nil }
    end
  end
end
