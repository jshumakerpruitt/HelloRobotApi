class UserMailer < ApplicationMailer
  def signup(addr, token)
    @to = addr
    @token = token
    mail(to: @to, from: 'no-reply@fake.com')
  end
end
