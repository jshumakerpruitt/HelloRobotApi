FactoryGirl.define do
  factory :user do
    username {SecureRandom.urlsafe_base64}
    email {"#{SecureRandom.urlsafe_base64}@fake.com"}
    age 35
    password 'validpass'
  end
end
