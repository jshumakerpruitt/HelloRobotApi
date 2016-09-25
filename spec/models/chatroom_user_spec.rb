require 'rails_helper'

RSpec.describe ChatroomUser, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:chatroom) { Chatroom.create(name: 'general') }
  let(:chatroom_user) do
    endChatroomUser.create(name: 'general')
  end

  it { should validate_presence_of(:chatroom) }
  it { should validate_presence_of(:user) }

  it { should belong_to(:user) }
  it { should belong_to(:chatroom) }
end
