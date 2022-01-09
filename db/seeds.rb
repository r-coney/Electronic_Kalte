User.create!(
  name: "admin",
  phone: "01000000000",
  email: "admin@example.com",
  admin: true,
  password: "password",
  password_confirmation: "password"
)

50.times do |n|
  User.create!(
    name: "サンプルスタッフ#{n + 1}",
    phone: "01000000000",
    email: "sample#{n + 1}@example.com",
    admin: "false",
    password: "password",
    password_confirmation: "password",
  )
end

50.times do |n|
  Customer.create!(
    name: "サンプル顧客#{n + 1}",
    gender: 1,
    birthday: "2000-01-10",
    phone: "02000000000",
    address: "日本"
  )
end

Customer.all.each do |customer|
  customer.kaltes.create!(
    menu: "サンプルカルテ",
    request: "サンプルデータ",
    menu_description: "サンプルのカルテです。",
    note: "サンプル"
  )
end
