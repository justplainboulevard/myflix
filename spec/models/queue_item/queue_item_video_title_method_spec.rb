
require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  describe '#video_title' do

    let(:video) { Fabricate(:video, title: 'This Is the Title') }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

    it 'returns the title of the associated video' do
      expect(queue_item.video_title).to eq('This Is the Title')
    end
  end
end
