class ChatroomUsersController < ApplicationController
  before_action :authenticate_user, :set_chatroom

  def create
    @chatroom_user = @chatroom.chatroom_users
                              .where(user_id: current_user.id)
                              .first_or_create
    if @chatroom_user
      render json: @chatroom_user, status: 200
    else
      render json: { error: 'something went wrong' }, status: 422
    end
  end

  def destroy
    @chatroom_users = ChatroomUser
                      .where(user_id: current_user.id)
                      .destroy_all
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end
