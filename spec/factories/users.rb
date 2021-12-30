FactoryBot.define do
  factory :user do
    name { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    admin { false }
    password_digest { "MyString" }
  end
end
