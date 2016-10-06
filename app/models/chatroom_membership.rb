class ChatroomMembership < ApplicationRecord
  validates :user, presence: :true
  validates :partner, presence: :true
  validates :chatroom, presence: :true

  belongs_to :user
  belongs_to :partner,
             class_name: User,
             foreign_key: :partner_id

  belongs_to :chatroom
end
