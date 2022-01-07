FactoryBot.define do
  factory :customer do
    sequence (:name) { |n| "テスト顧客#{n}" }
    birthday { '2021-12-17' }
    address { '日本' }
    gender { 0 }
    phone { "0100000000" }
  end
end
