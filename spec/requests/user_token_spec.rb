describe 'POST /user_token' do
  let(:user) { FactoryGirl.create(:user) }
  let(:params) do
    { params: { auth: { email: user.email, password: user.password } } }
  end

  let(:bad_params) do
    { params: { auth: { email: user.email, password: 'wrongpassword' } } }
  end

  it 'should return a jwt for valid signins' do
    post '/user_token', params
    expect(response.status).to eq(201)
    expect(json['jwt']).not_to eq(nil)
  end

  it 'should return 404 unless user is verified' do
    user.update_attribute(:verified, nil)
    post '/user_token', params
    expect(response.status).to eq(404)
  end

  it 'should respond with 404 if signin fails' do
    post '/user_token', bad_params
    expect(response.status).to eq(404)
  end
end

describe 'DELETE /user_token' do
  let(:user) { FactoryGirl.create(:user) }
  let(:params) do
    { params: { auth: { email: user.email, password: user.password } } }
  end
  let(:token) { get_token(user) }

  it 'should return message and status' do
    delete '/user_token', get_headers
    expect(response.status).to eq(200)
    expect(json['info']).to eq('success')
  end

  it 'should invalidate all tokens' do
    user = FactoryGirl.create(:user)
    other_headers = get_headers(user)
    headers = get_headers(user)
    delete '/user_token', headers

    get '/users', headers
    expect(response.status).to eq(401)

    get '/users', other_headers
    expect(response.status).to eq(401)
  end
end
