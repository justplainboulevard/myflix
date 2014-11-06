
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#deactivate' do

    it 'deactivates an active user' do

      user = Fabricate(:user, active: true)

      user.deactivate!

      expect(user).not_to be_active
    end
  end
end
