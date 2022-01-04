FactoryBot.define do
  factory :kalte do
    menu { "testメニュー" }
    request { "test要望" }
    menu_description { "test用のカルテ" }
    note { "test用のカルテのメモ" }
    customer
  end
end
