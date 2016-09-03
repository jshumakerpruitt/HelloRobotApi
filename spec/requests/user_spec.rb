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
  it 'should return a jwt given valid input' do
    user = FactoryGirl.build(:user)
    json_data = {user: {
                   username: user.username,
                   password: user.password,
                   age: user.age,
                   email: user.email}}
    post '/users', get_headers.merge({params: json_data})

    expect(json['jwt']).not_to eq(nil)
  end

  it 'should return error messages on failure' do
    user = FactoryGirl.create(:user)
    invalid_user = FactoryGirl.build(:user)
    json_data = {user: {
                   username: user.username,
                   password: nil,
                   age: nil,
                   email: user.email}}
    post '/users', get_headers.merge({params: json_data})

    expect(json.has_key?('errors')).to eq(true)

    errors = json['errors']
    expect(errors.has_key?('email')).to eq(true)
    expect(errors.has_key?('username')).to eq(true)
    expect(errors.has_key?('age')).to eq(true)
    expect(errors.has_key?('password')).to eq(true)
  end
end
