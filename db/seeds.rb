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

100.times do |i|
  gender = i % 2 == 0 ? 'male' : 'female'
  User.create(
    username: Faker::Internet.user_name,
    email: "fake#{i}@fake.com",
    age: (18..35).to_a.sample,
    password: 'fakefake',
    avatar: Faker::Avatar.image.gsub(/\?.*$/, ''),
    gender: gender,
    verified: true
  )
end
