describe 'UserLike resource' do
  let(:liked_user) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  before(:example) do
    params = { params: { like: { id: liked_user.id } } }
    post '/user_likes', get_headers(user).merge(params)
    post '/user_likes', get_headers(user).merge(params)
  end

  describe 'POST /user_likes' do
    it 'should create a new like' do
      expect(response.status).to eq(201)
      expect(liked_user.received_likes.count).to eq(1)
      expect(user.received_likes.count).to eq(0)
    end
  end

  describe 'GET /user_likes' do
    it 'should return a list of ids' do
      get '/user_likes', get_headers(user)
      expect(json.key?('users')).to eq(true)
      users = json['users']
      expect(users.length).to eq(1)
      expect(users.first['id']).to eq(liked_user.id)
    end
  end
end
