class User < ApplicationRecord
  has_secure_password
  validates :age, presence: true
  validates :email, presence: true
  validates :username, presence: true
end
