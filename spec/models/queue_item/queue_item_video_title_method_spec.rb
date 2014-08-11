
require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  describe '#video_title' do

    set_user
    set_video
    set_queue_item

    it 'returns the title of the associated video' do
      video.update_attributes(title: 'This Is the Title')
      expect(queue_item.video_title).to eq('This Is the Title')
    end
  end
end
