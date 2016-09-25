require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  let(:chatroom) { Chatroom.create(name: 'general') }

  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_presence_of(:name) }

  it { should have_many(:chatroom_users) }
  it { should have_many(:users) }
  it { should have_many(:messages) }
end
