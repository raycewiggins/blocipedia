#Random Data
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end
users = User.all

20.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

#Role Users
admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

premium = User.create!(
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)

standard = User.create!(
  email:    'standard@example.com',
  password: 'helloworld',
  role:     'standard'
)

#Output
puts 'Seed finished'
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
