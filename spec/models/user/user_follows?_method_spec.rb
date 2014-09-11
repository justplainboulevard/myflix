
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#follows?' do

    it 'returns false if the specified user does not have a follower relationship with the other specifed user' do
      user = Fabricate(:user)
      another_user = Fabricate(:user)

      expect(user.follows?(another_user)).to eq(false)
    end

    it 'returns true if the specified user has a follower relationship with the other specifed user' do
      user = Fabricate(:user)
      another_user = Fabricate(:user)
      Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)

      expect(user.follows?(another_user)).to eq(true)
    end
  end
end
