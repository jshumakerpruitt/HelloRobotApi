module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def get_headers
      user = User.create(username: SecureRandom.urlsafe_base64,
                         email: "#{SecureRandom.urlsafe_base64}@fake.com",
                         password: 'lajsdflkajsdflkjas',
                         age: 34)

      token = Knock::AuthToken.new(payload: {sub: user.id} ).token
      {headers: {"ACCEPT" => "application/json", "Authorization": "Bearer #{token}"}}
    end
  end
end
