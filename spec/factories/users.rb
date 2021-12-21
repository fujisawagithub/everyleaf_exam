FactoryBot.define do

  factory :user do
    name { '管理者' }
    email{ 'admin@admin.com' }
    password { '000000' }
    admin { true }
  end

  factory :user2, class: User do
    name { 'ユーザ' }
    email{ 'test@test.com' }
    password { '111111' }
    admin { false }
  end

  factory :user3, class: User do
    name { 'ユーザ2' }
    email{ 'test2@test2.com' }
    password { '222222' }
    admin { false }
  end
end
