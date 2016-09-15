#Random Data
10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end
users = User.all

20.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

#Role Users
admin = User.create!(
  name: 'Admin',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

premium = User.create!(
  name: 'Premium',
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)

standard = User.create!(
  name: 'Standard',
  email:    'standard@example.com',
  password: 'helloworld',
  role:     'standard'
)

#Output
puts 'Seed finished'
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
