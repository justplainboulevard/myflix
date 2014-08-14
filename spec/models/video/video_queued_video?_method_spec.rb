
require 'rails_helper'

RSpec.describe Video, type: :model do

  describe '.queued_video?' do

    it 'returns true if the user has already queued the video' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user_id: user.id, video_id: video.id)

      expect(user.queued_video?(video)).to eq(true)
    end

    it 'returns false if the user has not already queued the video' do
      user = Fabricate(:user)
      video = Fabricate(:video)

      expect(user.queued_video?(video)).to eq(false)
    end
  end
end
