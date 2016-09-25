class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :body, presence: true
  validates :chatroom, presence: true
  validates :user, presence: true
end
