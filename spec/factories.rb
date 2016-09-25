FactoryGirl.define do
  factory :message do
    chatroom nil
    user nil
    body 'MyText'
  end
  factory :chatroom_user do
    chatroom nil
    user nil
  end
  factory :chatroom do
    name 'MyString'
  end
  factory :user_like do
    user_id 1
    liked_user_id 1
  end
  factory :user do
    username { SecureRandom.urlsafe_base64 }
    email { "#{SecureRandom.urlsafe_base64}@fake.com" }
    age 35
    verified true
    password 'validpass'
  end
end
