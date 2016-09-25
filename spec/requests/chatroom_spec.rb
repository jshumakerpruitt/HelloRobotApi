describe 'Chatroom resource' do
  let(:user) { FactoryGirl.create(:user) }
  let(:chatroom) do
    Chatroom.create(name: 'random')
  end

  before(:example) do
    params = { params: { chatroom: { name: 'general' } } }
    post '/chatrooms', get_headers(user).merge(params)
  end

  describe 'POST /chatrooms' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /chatrooms' do
    it 'returns http success' do
      delete "/chatrooms/#{chatroom.id}",
             get_headers(user)
      expect(response).to have_http_status(:success)
    end
  end
end
