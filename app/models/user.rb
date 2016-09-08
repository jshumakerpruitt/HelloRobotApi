class User < ApplicationRecord
  has_secure_password
  validates :age, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}
  after_create :set_token_timestamp

  has_many :user_likes, dependent: :destroy

  has_many :received_likes,
           class_name: UserLike,
           foreign_key: :liked_user_id,
           dependent: :destroy

  has_many :liked_users,
           through: :user_likes

  def self.from_token_payload payload
    user = User.find(payload["sub"])
    issued_at =  payload['token_timestamp'].to_i
    return user if user && (user.token_timestamp.to_f * 1000).to_i <= issued_at
  end

  def self.from_token_request request
    email = request.params["auth"] && request.params["auth"]["email"]
    user = self.find_by email: email
    return user if user && user.verified
    return nil
  end

  def to_token_payload
    {sub: id, token_timestamp: (Time.now.to_f * 1000).to_i}
  end

  private
  def set_token_timestamp
    update_attribute(:token_timestamp, Time.now)
  end
end
