module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable',
                      "User #{current_user.id}"
    end

    protected

    def find_verified_user
      token = env['ORIGINAL_FULLPATH'].gsub(%r{\/cable\?token=}, '')

      user = User.from_token(token)
      if user
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
