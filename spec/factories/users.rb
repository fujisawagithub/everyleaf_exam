FactoryBot.define do
  factory :user do
    name { 'ユーザー' }
    email{ 'test@test.com' }
    password { '111111' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { '管理者' }
    email{ 'admin@admin.com' }
    password { '000000' }
    admin { true }
  end
end
