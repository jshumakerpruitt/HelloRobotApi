# create users. TODO: create likes
User.create(
  username: 'fake',
  password: 'fakefake',
  email: 'fake@fake.com',
  age: 18,
  avatar: Faker::Avatar.image.gsub(/\?.*$/, ''),
  gender: 'Male',
  verified: true
)

100.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.safe_email,
    age: (18..35).to_a.sample,
    password: 'validpass',
    avatar: Faker::Avatar.image.gsub(/\?.*$/, '')
  )
end
