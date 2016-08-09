require 'random_data'

5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

10.times do
  Wiki.create!(
    title: 'Wiki title',
    body: 'Body content'
  )
end
wikis = Wiki.all

admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

member = User.create!(
  email:    'member@example.com',
  password: 'helloworld'
)

puts 'Seed finished'
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
