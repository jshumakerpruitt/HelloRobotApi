class User < ApplicationRecord
  has_secure_password
  validates :age, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
  after_create :set_token_timestamp

  has_many :user_likes, dependent: :destroy

  has_many :received_likes,
           class_name: UserLike,
           foreign_key: :liked_user_id,
           dependent: :destroy

  has_many :liked_users,
           through: :user_likes

  has_many :messages
  has_many :chatroom_users

  has_many :chatroom_memberships, inverse_of: :user
  has_many :received_memberships, inverse_of: :partner

  has_many :partners,
           through: :chatroom_memberships

  has_many :chatrooms, through: :chatroom_memberships

  def self.from_token_payload(payload)
    user = User.find(payload['sub'])
    issued_at = payload['token_timestamp'].to_i
    return user if user && (user.token_timestamp.to_f * 1000).to_i <= issued_at
  end

  def self.from_token_request(request)
    email = request.params['auth'] && request.params['auth']['email']
    user = find_by email: email
    return user if user && user.verified
    nil
  end

  def self.from_token(token)
    knock_token = Knock::AuthToken.new(token: token)
    from_token_payload(knock_token.payload)
  rescue => e
    logger.warn(e)
    nil
  end

  def self.verify_from_token(token)
    user = from_token token
    if user
      user.update_attribute(:verified, true)
      user.logout_all
      user
    end
  end

  def to_token_payload
    { sub: id, token_timestamp: (token_timestamp.to_f * 1000).to_i }
  end

  def to_valid_token
    Knock::AuthToken.new(payload: to_token_payload).token
  end

  def logout_all
    set_token_timestamp
  end

  private

  def set_token_timestamp
    update_attribute(:token_timestamp, Time.now.getlocal)
  end
end
