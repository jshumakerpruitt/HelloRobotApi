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
    expect(json.has_key?('user')).to eq(true)
  end

  it 'should return public info' do
    user = FactoryGirl.create(:user)
    get "/users/#{user.id}", get_headers
    expect(json['user']['username']).not_to eq(nil)
    expect(json['user']['age']).not_to eq(nil)
  end
end

describe 'POST /users' do
  let( :saved_user  ) { FactoryGirl.create(:user) }
  let( :user  ) { FactoryGirl.build(:user) }
  after(:each) { user.destroy}

  it 'should return a success message' do
    json_data = {user: {
                   username: user.username,
                   password: user.password,
                   age: user.age,
                   email: user.email}}
    post '/users', get_headers.merge({params: json_data})

    expect(json.has_key?('status')).to eq(true)
    expect(json['status']).to eq('created')
    expect(response.status).to eq(201)
    expect(json.has_key?('errors')).to eq(false)
  end

  it 'should send a confirmation email' do
    delivery = double
    expect(delivery).to receive(:deliver_now)
    expect( UserMailer).to receive(:signup).and_return(delivery)
    json_data = {user: {
                   username: user.username,
                   password: user.password,
                   age: user.age,
                   email: user.email}}
    post '/users', get_headers.merge({params: json_data})
  end

  it 'should return error messages on failure' do
    invalid_user = FactoryGirl.build(:user)
    json_data = {user: {
                   username: saved_user.username,
                   password: nil,
                   age: nil,
                   email: saved_user.email}}
    post '/users', get_headers.merge({params: json_data})

    expect(json.has_key?('errors')).to eq(true)

    errors = json['errors']
    expect(errors.has_key?('email')).to eq(true)
    expect(errors.has_key?('username')).to eq(true)
    expect(errors.has_key?('age')).to eq(true)
    expect(errors.has_key?('password')).to eq(true)
  end
end

describe "GET /verify" do
  let!(:user) { FactoryGirl.create(:user, verified: false)}

  it "should read the token param" do
    url = get_verify_link(user)
    get url
    expect(response
            .request
            .filtered_parameters
            .has_key?("token")
          ).to eq(true)
  end

  it "it should bypass authenticate_user" do
    url = get_verify_link(user)
    get url
    expect(response.status).to eq(200)
  end

  it "should validate the user" do
    url = get_verify_link(user)
    get url
    expect(user.reload.verified).to eq(true)
  end

  it "should return a fresh token" do
    url = get_verify_link(user)
    get url
    expect(json.has_key?("jwt")).to eq(true)
  end

  it "should invalidate emailed token" do
    url = get_verify_link(user)
    get url
    get url
    expect(response.status).to eq(401)
  end

end
