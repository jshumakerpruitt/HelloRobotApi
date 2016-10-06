class ChatroomMembershipsController < ApplicationController
  before_action :authenticate_user
  def create
    partner = User.find(params[:partner_id])
    membership = find_membership(partner)
    ensure_chatroom(membership)
    membership.save!
    render json: { chatroomId: membership.chatroom.id },
           status: 200
  rescue => e
    logger.warn(e)
    render json: {}, status: 422
  end

  private

  def find_membership(partner)
    current_user
      .chatroom_memberships
      .where(partner_id: partner.id)
      .first_or_initialize
  end

  def ensure_chatroom(membership)
    unless membership.persisted?
      chatroom = Chatroom.create(name: SecureRandom.urlsafe_base64)
      membership.chatroom_id = chatroom.id
      return if membership.partner_id == membership.user_id
      ChatroomMembership.create(
        user_id: membership.partner_id,
        partner_id: membership.user_id,
        chatroom_id: chatroom.id
      )
    end
  end
end
