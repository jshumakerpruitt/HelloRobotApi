require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'fake@fake.com',
                        username: 'johndoe',
                        password: 'validpass',
                        age: '21') }

  describe '#create' do
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
