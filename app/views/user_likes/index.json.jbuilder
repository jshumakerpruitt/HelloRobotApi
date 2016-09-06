json.users do
  json.array! @liked_users do |user|
    json.id user.id
    json.username user.username
  end
end
