class MessagesController < ApplicationController
  before_action :authenticate_user, :set_chatroom

  def create
    @message = @chatroom.messages.create(message_params)
    @message.user_id = current_user.id
    if @message.save
      render json: @message, status: :created
    else
      render json: {}, status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
    end


  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end
