require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:password) }
  it { should respond_to(:token_date) }

  it do
    should validate_length_of(:password)
      .is_at_least(8)
      .on(:create)
  end

  it { should have_many(:user_likes) }
  it { should have_many(:received_likes) }
  it { should have_many(:liked_users) }

  describe 'from_token_request' do
    let(:user) { FactoryGirl.create(:user) }
    let(:auth_request) { double }
    let(:auth_hash) { { 'auth' => { 'email' => user.email } } }
    before(:each) do
      expect(auth_request).to receive(:params).twice.and_return(auth_hash)
    end

    it 'should return nil unless user is verified' do
      user.update_attribute(:verified, false)
      expect(User.from_token_request(auth_request)).to eq(nil)
    end

    it 'should return the user if verified' do
      expect(User.from_token_request(auth_request)).not_to eq(nil)
    end
  end

  describe 'likes' do
    let(:user) { FactoryGirl.create(:user) }
    let(:liked_user) { FactoryGirl.create(:user) }
    before(:example) { user.liked_users << liked_user }

    it 'should increase liked user count' do
      expect(user.liked_users.count).to eq(1)
    end

    it 'should increase the recipients received likes' do
      expect(liked_user.received_likes.count).to eq(1)
    end

    it 'should delete the received like on deletion of liker' do
      user.destroy
      expect(liked_user.received_likes.count).to eq(0)
    end

    it 'should delete the like on deletion of likee' do
      liked_user.destroy
      expect(user.user_likes.count).to eq(0)
    end
  end

  describe 'self.from_token' do
    let(:user) { FactoryGirl.create(:user, verified: false) }

    it 'should return the User from a valid token' do
      token = user.to_valid_token
      expect(User.from_token(token).id).to eq(user.id)
    end

    it "shouldn't raise errors from invalid tokens" do
      expect { User.from_token 'notatoken' }
        .not_to raise_error
    end

    it "should return nil if user doesn't exist" do
      old_token = user.to_valid_token
      user.destroy
      expect(User.from_token(old_token)).to eq(nil)
    end
  end

  describe '#logout_all' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should increase the value of token_timestamp' do
      old_timestamp = user.token_timestamp
      user.logout_all
      user.reload
      expect(old_timestamp < user.token_timestamp).to eq(true)
    end

    it 'should return true' do
      expect(user.logout_all).to eq(true)
    end
  end

  describe '.verify_from_token' do
    let(:user) { FactoryGirl.create(:user, verified: false) }

    it 'should return the user if found' do
      token = user.to_valid_token
      expect(User.verify_from_token(token)).to eq(user)
    end

    it 'should verify the user' do
      token = user.to_valid_token
      User.verify_from_token token
      expect(user.reload.verified).to eq(true)
    end

    it 'should call #logout_all' do
      token = user.to_valid_token
      t1 = user.token_timestamp
      User.verify_from_token token
      expect(t1 < user.reload.token_timestamp).to eq(true)
    end
  end
end
