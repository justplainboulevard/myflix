
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#can_follow?' do

    it 'returns false if the current user has a follower relationship with the other specifed user' do
      user = Fabricate(:user)
      another_user = Fabricate(:user)
      Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)

      expect(user.can_follow?(another_user)).to eq(false)
    end

    it 'returns false if the current user is the same as the specifed user' do
      user = Fabricate(:user)

      expect(user.can_follow?(user)).to eq(false)
    end

    it 'returns true if the current user does not have a follower relationship with the other specifed user' do
      user = Fabricate(:user)
      another_user = Fabricate(:user)
      Fabricate(:relationship, follower_id: another_user.id, leader_id: user.id)

      expect(user.can_follow?(another_user)).to eq(true)
    end
  end
end
