FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    phone { "00000000000" }
    email { "test@example.com" }
    admin { false }
    password_digest { "password" }
  end
end