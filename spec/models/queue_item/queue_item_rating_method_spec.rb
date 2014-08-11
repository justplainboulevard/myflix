
require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  describe '#rating' do

    set_user
    set_video
    set_queue_item

    context 'where the user has reviewed and rated the video' do

      it 'returns the user rating' do
        Fabricate(:review, user_id: user.id, video_id: video.id, rating: 3)

        expect(queue_item.rating).to eq(3)
      end
    end

    context 'where the user has not reviewed and rated the video' do

      it 'returns nil' do
        expect(queue_item.rating).to eq(nil)
      end
    end
  end
end
