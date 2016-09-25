# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatroom:#{chatroom.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    @chatroom = Chatroom.find(data["chatroom_id"])
    message = @chatroom.messages.new({body: data["body"]})
    message.user = current_user
    message.save
    MessageRelayJob.perform_later(message)
  end
end
