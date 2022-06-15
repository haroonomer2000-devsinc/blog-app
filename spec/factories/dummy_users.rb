FactoryBot.define do
  factory :user do
    sequence(:email) { |n|  "haroon#{n}@example.com" }
    password { "haroon" }
    role { "moderator" }
    confirmed_at {Time.now}
  end
end
