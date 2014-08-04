# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  list_order :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe '#video_title' do

    let(:video) { Fabricate(:video, title: 'This Is the Title') }
    let(:queue_item) { Fabricate(:queue_item, video_id: video.id) }

    it 'returns the title of the associated video' do
      expect(queue_item.video_title).to eq('This Is the Title')
    end
  end

  describe '#rating' do

    context 'where the user has rated the video' do

      let(:video) { Fabricate(:video) }
      let(:user) { Fabricate(:user) }

      let(:review) { Fabricate(:review, user_id: user.id, video_id: video.id, rating: 3) }
      let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

      it 'returns the user rating' do
        expect(queue_item.rating).to eq(3)
      end
    end

    context 'where the user has not rated the video' do

      let(:video) { Fabricate(:video) }
      let(:user) { Fabricate(:user) }
      let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

      it 'returns nil' do
        expect(queue_item.rating).to eq(nil)
      end
    end
  end
end
