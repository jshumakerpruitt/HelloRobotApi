describe "Users endpoint" do
  describe 'GET /users' do
    it 'should send a list of users' do
      3.times{FactoryGirl.build(:user)}
      user = FactoryGirl.create(:user)
      token = Knock::AuthToken.new(payload: {sub: user}    ).token

      get '/users' , headers: {"Authoriztion": "Bearer #{token}"}
      expect(response).to be_success

      expect(json['users'.length]).to eq(10)
    end
  end
end
