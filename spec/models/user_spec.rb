require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe '#create' do
    it 'should require a unique email' do
      user.email = 'fake@fake.com'
      user.save
      other_user = FactoryGirl.build(:user)
      other_user.email = 'fake@fake.com'
      expect{ other_user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[eE]mail.*taken/)
    end

    it 'should require a Username' do
      user.username = 'foobar'
      user.save
      other_user = FactoryGirl.build(:user)
      other_user.username = 'foobar'
      expect{ other_user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[uU]sername.*taken/)
    end

    it 'should work with a password, email, username, age' do
      expect{ user.save! }.not_to raise_exception()
    end

    it('should require a password') do
      user.password = nil
      expect{ user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[pP]assword/)
    end

    it('should require a username') do
      user.username = nil
      expect{ user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[Uu]sername/)
    end

    it('should require an email') do
      user.email = nil
      expect{ user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[eE]mail/)
    end

    it('should require an age') do
      user.age = nil
      expect{ user.save! }.to raise_exception(ActiveRecord::RecordInvalid, /[aA]ge/)
    end
  end

end
