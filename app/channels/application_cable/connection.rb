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
      token = self.env['ORIGINAL_FULLPATH'].gsub(/\/cable\?token=/, '')
      logger.warn "zzzz: #{token}"

      if user = User.from_token(token)
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
