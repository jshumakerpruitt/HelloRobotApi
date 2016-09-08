FactoryGirl.define do
  factory :user_like do
    user_id 1
    liked_user_id 1
  end
  factory :user do
    username {SecureRandom.urlsafe_base64}
    email {"#{SecureRandom.urlsafe_base64}@fake.com"}
    age 35
    verified true
    password 'validpass'
  end

end
