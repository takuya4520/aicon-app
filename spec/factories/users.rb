FactoryBot.define do
  factory :user do
    sequence(:title) { |n| "user_#{n}@example.com" }
    sequence(:name) { |n| "user_name_#{n}" }
    password { "password" }
    password_confirmation { "password" }
  end
end
