require 'rails_helper'

RSpec.describe UserLike, type: :model do
  it {should belong_to(:user) }
  it {should belong_to(:liked_user) }

end
