FactoryBot.define do
  factory :post_icon do
    sequence(:title) { |n| "RUNTEQ_#{n}" }
    sequence(:name) { |n| "user_name_#{n}" }
    password { "password" }
    password_confirmation { "password" }
  end
end
