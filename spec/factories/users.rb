FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    phone { "01000000000" }
    sequence(:email) { |n|"test_user#{n}@example.com" }
    admin { true }
    password { "password" }
  end
end
