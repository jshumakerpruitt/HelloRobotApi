class User < ApplicationRecord
  has_secure_password
  validates :age, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}

  def self.from_token_payload payload
    User.find(payload["sub"])
  end
end
