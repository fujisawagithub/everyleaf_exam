FactoryBot.define do

  factory :admin_user do
    name { '管理者' }
    email{ 'admin@admin.com' }
    password { '000000' }
    admin { true }
  end

  factory :user, class: User do
    name { 'ユーザ' }
    email{ 'test@test.com' }
    password { '111111' }
    admin { false }
  end

  factory :second_user, class: User do
    name { 'ユーザ2' }
    email{ 'test2@test2.com' }
    password { '222222' }
    admin { false }
  end
end
