describe "Users endpoint" do
  describe 'GET /users' do

    it 'should send a list of users' do
      3.times{ |x|  FactoryGirl.create(:user)}
      get '/users', get_headers
      expect(response).to be_success

      #get_headers creates a user, so expect 4 instead of 3
      expect(json['users'].length).to eq(4)
    end

    it 'should include public details' do
      get '/users', get_headers
      user = json['users'].first
      expect(user['username']).not_to be_nil
    end
  end

  describe 'GET /users/:id' do
    it 'should return one user' do
      user = FactoryGirl.create(:user)
      get "/users/#{user.id}", get_headers

      expect(json['user'].has_key?('username')).to eq(true)
      expect(json['user'].has_key?('age')).to eq(true)
    end
  end
end
