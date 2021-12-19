FactoryBot.define do
  factory :customer do
    name { 'テスト顧客' }
    birthday { '2021-12-17' }
    address { '滋賀県 大津市' }
    gender { 0 }
    phone { '000000000' }
  end
end
