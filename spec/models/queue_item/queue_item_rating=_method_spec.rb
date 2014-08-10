
require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  describe '#rating=' do

    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

    context 'where the user has rated the video' do

      it 'updates the user rating if one is selected' do
        Fabricate(:review, user_id: user.id, video_id: video.id, rating: 3)
        queue_item.rating = 5
        expect(Review.first.rating).to eq(5)
      end

      it 'updates the user rating if one is not selected' do
        Fabricate(:review, user_id: user.id, video_id: video.id, rating: 3)
        queue_item.rating = nil
        expect(Review.first.rating).to be_nil
      end
    end

    context 'where the user has not rated the video' do

      it 'creates a review and assigns the specified rating to the review' do
        queue_item.rating = 3
        expect(Review.first.rating).to eq(3)
      end
    end
  end
end
