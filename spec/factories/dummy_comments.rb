FactoryBot.define do
  factory :comment do
    body { "This is a dummy comment" }
    post_id { 1 }
    user_id { 1 }
    parent_id { 1 }
    status { nil }
  end
end
