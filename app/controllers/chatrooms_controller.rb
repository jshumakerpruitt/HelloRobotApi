class ChatroomsController < ApplicationController
  before_action :authenticate_user

  def create
  end

  def destroy
  end

  def show
    chatroom_id = params[:id]
    @messages = Chatroom
                .find(chatroom_id)
                .messages
                .order(created_at: :desc)
                .limit(100)
                .reverse
  end
end
