#------------------------------
# Test helpers: gets tokens, Auth Headers,
# verify urls, etc
#------------------------------
module Requests
  #------------------------------
  # Test helpers: gets tokens, Auth Headers,
  # verify urls, etc
  #------------------------------
  module RequestHelpers
    def json
      JSON.parse(response.body)
    end

    def get_headers(user = nil)
      user ||= FactoryGirl.create(:user)
      token = get_token(user)
      {
        headers: {
          'ACCEPT' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      }
    end

    def get_token(user)
      post '/user_token',
           params: {
             auth:  {
               email: user.email,
               password: user.password
             },
             format: 'json'
           }
      json['jwt']
    end

    def get_verify_link(user)
      "/verify?token=#{CGI.escape user.to_valid_token}"
    end
  end
end
