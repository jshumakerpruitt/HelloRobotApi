describe 'POST /user_token' do
  let(:user) { FactoryGirl.create(:user) }
  it "should return a jwt for valid signins" do
    params = {params: {auth: {email: user.email, password: user.password}}}
    post '/user_token', get_headers.merge(params)
    expect(response.status).to eq(201)
    expect(json['jwt']).not_to eq(nil)
  end

  it "should respond with 404 if signin fails" do
    params = {params: {auth: {email: user.email, password: 'wrongpassword'}}}
    post '/user_token', get_headers.merge(params)
    expect(response.status).to eq(404)
  end

end
