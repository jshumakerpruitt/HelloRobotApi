class Chatroom < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages
end
