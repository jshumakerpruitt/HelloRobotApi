module Requests
  module RequestHelpers
    def json
      JSON.parse(response.body)
    end

    def get_headers(user = nil)
      user ||=  User.create(username: SecureRandom.urlsafe_base64,
                         email: "#{SecureRandom.urlsafe_base64}@fake.com",
                         password: 'lajsdflkajsdflkjas',
                         verified: true,
                         age: 34)

      token = get_token(user)
      {headers: {"ACCEPT" => "application/json", "Authorization": "Bearer #{token}"}}
    end

    def get_token(user)
      post '/user_token', {params:  {auth:  {email: user.email, password: user.password}, format: 'json'}}
      return json["jwt"]
    end
  end
end
