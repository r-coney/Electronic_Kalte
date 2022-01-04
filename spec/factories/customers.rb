FactoryBot.define do
  factory :customer do
    name { 'テスト顧客' }
    birthday { '2021-12-17' }
    address { '日本' }
    gender { 0 }
    phone { '01000000000' }
  end
end
