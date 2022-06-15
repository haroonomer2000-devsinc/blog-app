FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Dummy Post 1=#{n}" }
    description { "This is the description of Dummy Post 1 description" }
    user_id { 1 }
    status { 0 }
  end
end
