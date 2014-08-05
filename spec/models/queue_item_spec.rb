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
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

    it 'returns the title of the associated video' do
      expect(queue_item.video_title).to eq('This Is the Title')
    end
  end

  describe '#rating' do

    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }

    context 'where the user has rated the video' do

      let(:review) { Fabricate(:review, user_id: user.id, video_id: video.id, rating: 3) }

      it 'returns the user rating' do
        expect(queue_item.rating).to eq(3)
      end
    end

    context 'where the user has not rated the video' do

      it 'returns nil' do
        expect(queue_item.rating).to eq(nil)
      end
    end
  end

  # describe '#category_names' do

  #   let(:video) { Fabricate(:video) }
  #   let(:user) { Fabricate(:user) }

  #   it 'it returns an array of the category names for the video' do

  #     new_categories = Fabricate.times(2, :category)
  #     new_categories.each do |category|
  #       Fabricate(:video_category, video_id: video.id, category_id: category.id)
  #     end
  #     names = []
  #     video.categories.each do |category|
  #       names << category.name
  #     end
  #     queue_item = Fabricate(:queue_item, user_id: user.id, video_id: video.id)

  #     expect(queue_item.category_names).to match_array(names)
  #   end
  # end
end
