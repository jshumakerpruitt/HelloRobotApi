class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast( "chatroom:#{message.chatroom_id}", {
                                    message:{ id: message.id, body:  message.body},
                                    chatroom_id: message.chatroom_id
                                  }
                                )
  end
end
