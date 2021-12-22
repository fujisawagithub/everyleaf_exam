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

10.times do |n|
  User.create(
    name: "user#{n+1}",
    email: "user#{n+1}@user.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
end

10.times do |n|
  Task.create(
    title: "task#{n+1}",
    content: "content#{n+1}",
    deadline: DateTime.now,
    status: rand(3),
    priority: rand(3),
    user_id: rand(21..31)
  )
end

10.times do |n|
  Label.create(
    name:"label#{n+1}"
  )
end