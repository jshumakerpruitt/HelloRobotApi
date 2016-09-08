require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:password) }

    it do
      should validate_length_of(:password)
              .is_at_least(8)
              .on(:create)
    end

    it { should have_many(:user_likes) }
    it { should have_many(:received_likes) }
    it { should have_many(:liked_users) }

    describe "from_token_request" do
      let(:user)  {FactoryGirl.create(:user)}
      let( :auth_request  ) { double }
      let( :auth_hash  ) { {"auth" => {"email" => user.email}}}
      before(:each) do
        expect(auth_request).to receive(:params).twice.and_return(auth_hash)
      end

      it "should return nil unless user is verified" do
        expect(User.from_token_request(auth_request)).to eq(nil)
      end

      it "should return the user if verified" do
        user.verified = true
        user.save
        expect(User.from_token_request(auth_request)).not_to eq(nil)
      end

    end

    describe 'likes' do
      let(:user) {FactoryGirl.create(:user) }
      let(:liked_user) {FactoryGirl.create(:user) }
      before(:example) {user.liked_users << liked_user}

      it "should increase liked user count" do
        expect(user.liked_users.count).to eq(1)
      end

      it "should increase the recipients received likes" do
        expect(liked_user.received_likes.count).to eq(1)
      end

      it "should delete the received like on deletion of liker" do
        user.destroy
        expect(liked_user.received_likes.count).to eq(0)
      end

      it "should delete the like on deletion of likee" do
        liked_user.destroy
        expect(user.user_likes.count).to eq(0)
      end
    end
end
