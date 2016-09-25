describe 'Messages resource' do
  let(:user) { FactoryGirl.create(:user) }
  let(:chatroom) { Chatroom.create(name: 'general') }
  let(:params) do
    {
      params: {
        chatroom_id: chatroom.id, message: {body: 'message body'}
      }
    }
  end

  describe 'POST /messages' do
    it 'returns http success' do
      post '/messages', get_headers(user).merge(params)
      expect(response).to have_http_status(:created)
    end

    it 'returns 422 if body is blank' do
      params[:params][:message][:body] = nil
      post '/messages', get_headers(user).merge(params)
      expect(response).to have_http_status(422)
    end
  end
end
