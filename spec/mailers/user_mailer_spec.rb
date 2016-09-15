require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'SignUp mailer' do
    let(:email) { UserMailer.signup('fake@fake.com', 'my.token') }
    # before(:all){ email.deliver_now }
    it 'should have a link with a token' do
      link = %r{localhost:3000\/verify\?token=#{CGI.escape('my.token')}}
      expect(link =~ email.body.to_s).not_to be(nil)
    end

    it 'should have a from address' do
      expect(email.from.pop).to eq('no-reply@fake.com')
    end

    it 'should be sent to the proper addresss' do
      expect(email.to.pop).to eq('fake@fake.com')
    end
  end
end
