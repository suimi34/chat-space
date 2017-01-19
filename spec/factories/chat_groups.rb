require 'faker'
FactoryGirl.define do
  sample_time = Faker::Time.between(2.days.ago, Time.now, :all)

  factory :chat_group do
    name                      { Faker::Lorem.words }
    created_at                sample_time
    updated_at                sample_time
    after(:create) do |chat_group|
      chat_group.users << FactoryGirl.create(:user, name: Faker::Name.name)
      chat_group.users << FactoryGirl.create(:user, name: Faker::Name.name)
    end
  end
end
