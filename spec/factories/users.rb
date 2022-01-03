FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    phone { "01000000000" }
    email { "test_user@example.com" }
    admin { false }
    password { "password" }
  end
end
