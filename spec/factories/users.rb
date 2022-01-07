FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テストユーザー#{n}" }
    phone { "01000000000" }
    sequence(:email) { |n|"test_user#{n}@example.com" }
    admin { true }
    password { "password" }
  end
end
