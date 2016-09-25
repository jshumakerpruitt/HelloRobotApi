class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast( "chatroom:#{message.chatroom_id}", {
                                    message: message.body,
                                    chatroom_id: message.chatroom_id
                                  }
                                )
  end
end
