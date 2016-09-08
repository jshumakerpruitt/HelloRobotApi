describe 'POST /user_token' do
  let(:user) { FactoryGirl.create(:user, verified: true) }
  let(:params ) { {params: {auth: {email: user.email, password: user.password}}} }
  let(:bad_params ) { {params: {auth: {email: user.email, password: 'wrongpassword'}}} }
  

  it "should return a jwt for valid signins" do
    post '/user_token', params
    expect(response.status).to eq(201)
    expect(json['jwt']).not_to eq(nil)
  end

  it "should return 404 unless user is verified" do
    user.update_attribute(:verified, nil)
    post '/user_token', params
    expect(response.status).to eq(404)
  end

  it "should respond with 404 if signin fails" do
    post '/user_token', bad_params
    expect(response.status).to eq(404)
  end

end
