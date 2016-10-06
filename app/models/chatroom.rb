class Chatroom < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  has_many :chatroom_memberships, inverse_of: :chatroom
  has_many :users,
           through: :chatroom_memberships
  has_many :partners, through: :chatroom_memberships
  has_many :messages
end
