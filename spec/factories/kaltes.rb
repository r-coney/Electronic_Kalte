FactoryBot.define do
  factory :kalte do
    menu { "cut" }
    request { "テスト" }
    menu_description { "テストのカルテ" }
    note { "テストカルテのメモ" }
  end
end
