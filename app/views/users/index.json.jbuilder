json.users do
  json.array!(@users) do |user| 
    json.username user.username
    json.age user.age
  end
end
