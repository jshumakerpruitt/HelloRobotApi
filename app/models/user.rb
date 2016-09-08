class User < ApplicationRecord
  has_secure_password
  validates :age, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}

  has_many :user_likes, dependent: :destroy

  has_many :received_likes,
           class_name: UserLike,
           foreign_key: :liked_user_id,
           dependent: :destroy

  has_many :liked_users,
           through: :user_likes

  def self.from_token_payload payload
    User.find(payload["sub"])
  end

  def self.from_token_request request
    email = request.params["auth"] && request.params["auth"]["email"]
    user = self.find_by email: email
    return user if user && user.verified
    return nil
  end

end
