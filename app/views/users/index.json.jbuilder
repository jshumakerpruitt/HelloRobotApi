json.users do
  json.array!(@users) do |user|
    json.username user.username
    json.age user.age
    json.id user.id
    json.avatar user.avatar
    json.liked !user.liked.nil?
  end
end
