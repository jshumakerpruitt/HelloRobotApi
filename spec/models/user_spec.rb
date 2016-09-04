require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe '#create' do

    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email)}

    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username)}

    it { should validate_presence_of(:age)}

    it { should validate_presence_of(:password)}
    it do
      should validate_length_of(:password)
              .is_at_least(8)
              .on(:create)
    end

    describe '#update' do
    end

  end

end
