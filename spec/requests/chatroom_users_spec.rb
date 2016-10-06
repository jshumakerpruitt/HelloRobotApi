describe 'Chatroom resource' do
  let(:user) { FactoryGirl.create(:user) }
  let(:chatroom) do
    Chatroom.create(name: 'random')
  end
  let(:params) do
    { params: { chatroom_id: chatroom.id } }
  end

  before(:example) do
    #    post '/chatroom_users', get_headers(user).merge(params)
  end

  describe 'POST /chatrooms' do
    it 'returns http success' do
      #      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /chatrooms' do
    it 'returns http success' do
      #      delete "/chatroom_users/#{chatroom.id}",
      #            get_headers(user).merge(params)
      #    expect(response).to have_http_status(:success)
    end
  end
end
