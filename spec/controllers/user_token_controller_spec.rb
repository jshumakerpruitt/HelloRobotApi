require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do

  describe "destroy" do
    let(:user) {FactoryGirl.create(:user)}
    it "should invalidate all existing tokens" do
    end
  end

end
