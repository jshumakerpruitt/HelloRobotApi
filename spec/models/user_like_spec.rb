require 'rails_helper'

RSpec.describe UserLike, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:liked_user) }
  it { should validate_uniqueness_of(:liked_user_id).scoped_to(:user_id) }
end
