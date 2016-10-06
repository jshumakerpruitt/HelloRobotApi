json.messages do
  json.array!(@messages) do |message|
    json.id message.id
    json.userId message.user_id
    json.chatroomId message.chatroom_id
    json.body message.body
    json.createdAt message.created_at
  end
end
