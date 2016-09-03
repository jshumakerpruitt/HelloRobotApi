FactoryGirl.define do
  factory :user do
    username 'johndoe'
    email 'johndoe@fake.com'
    age 35
    password 'validpass'
  end
end
