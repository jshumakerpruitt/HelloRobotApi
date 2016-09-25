require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { Message.create(body: 'message body') }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:chatroom) }

  it { should belong_to(:user) }
  it { should belong_to(:chatroom) }
end
