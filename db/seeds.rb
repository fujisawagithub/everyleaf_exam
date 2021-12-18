User.create!(
  name: 'admin',
  email: 'admin@admin.com',
  password: '000000',
  password_confirmation: '000000',
  admin: true
)

User.create!(
  name: 'test',
  email: 'test@test.com',
  password: '111111',
  password_confirmation: '111111',
)