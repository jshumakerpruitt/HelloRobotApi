json.user do
  json.username @user.username
  json.age @user.age
  json.gender @user.gender
  json.avatar @user.avatar
  json.id @user.id
  json.liked @user.liked.nil?
end
