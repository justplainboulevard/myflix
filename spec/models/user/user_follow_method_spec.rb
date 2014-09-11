
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#follow' do

    context 'where the first specified user is not the same as the second specified user' do

      it 'creates a follower relationship between the first specified user and the second specified' do
        user = Fabricate(:user)
        another_user = Fabricate(:user)
        user.follow(another_user)

        expect(user.follows?(another_user)).to eq(true)
      end
    end

    context 'where the first specified user is the same as the second specified user' do

      it 'does not create a follower relationship between the first specified user and the second specified' do
        user = Fabricate(:user)
        user.follow(user)

        expect(user.follows?(user)).to eq(false)
      end
    end
  end
end
