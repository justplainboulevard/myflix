# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Category, type: :model do

  it { should have_many(:video_categories) }
  it { should have_many(:videos).through(:video_categories) }

  it { should validate_presence_of(:name) }

  describe '#recent_videos' do

    let(:category) { Fabricate(:category) }

    it 'returns an empty array if there are no videos in the category' do

      expect(category.most_recent).to eq([])
    end

    it 'returns an array of all videos in the category if there are six or fewer' do

      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')
      video_three = Video.create(title: 'My Video Three', description: 'My video three description.')
      video_four = Fabricate(:video)
      video_category_one = VideoCategory.create(category_id: category.id, video_id: video_one.id)
      video_category_two = VideoCategory.create(category_id: category.id, video_id: video_two.id)
      video_category_three = VideoCategory.create(category_id: category.id, video_id: video_three.id)
      video_category_four = Fabricate(:video_category, category_id: category.id, video_id: video_four.id)

      expect(category.most_recent).to include(video_one, video_two, video_three, video_four)
    end

    it 'returns an array of only six videos if there are more than six videos in the category' do

      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')
      video_three = Video.create(title: 'My Video Three', description: 'My video three description.')
      video_four = Video.create(title: 'My Video Four', description: 'My video four description.')
      video_five = Video.create(title: 'My Video Five', description: 'My video five description.')
      video_six = Video.create(title: 'My Video Six', description: 'My video six description.')
      video_seven = Video.create(title: 'My Video Seven', description: 'My video seven description.')
      video_category_one = VideoCategory.create(category_id: category.id, video_id: video_one.id)
      video_category_two = VideoCategory.create(category_id: category.id, video_id: video_two.id)
      video_category_three = VideoCategory.create(category_id: category.id, video_id: video_three.id)
      video_category_four = VideoCategory.create(category_id: category.id, video_id: video_four.id)
      video_category_five = VideoCategory.create(category_id: category.id, video_id: video_five.id)
      video_category_six = VideoCategory.create(category_id: category.id, video_id: video_six.id)
      video_category_seven = VideoCategory.create(category_id: category.id, video_id: video_seven.id)

      expect(category.most_recent.size).to eq(6)
    end

    it 'returns an array ordered by created_at in reverse chronological order if two or more videos in the category' do

      video_one = Video.create(title: 'My Video One', description: 'My video one description.', created_at: 1.day.ago)
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.', created_at: 2.days.ago)
      video_three = Video.create(title: 'My Video Three', description: 'My video three description.', created_at: 1.day.ago)
      video_four = Video.create(title: 'My Video Four', description: 'My video four description.', created_at: 2.days.ago)
      video_five = Video.create(title: 'My Video Five', description: 'My video five description.', created_at: 1.day.ago)
      video_six = Video.create(title: 'My Video Six', description: 'My video six description.', created_at: 2.days.ago)
      video_seven = Video.create(title: 'My Video Seven', description: 'My video seven description.', created_at: 1.day.ago)
      video_category_one = VideoCategory.create(category_id: category.id, video_id: video_one.id)
      video_category_two = VideoCategory.create(category_id: category.id, video_id: video_two.id)
      video_category_three = VideoCategory.create(category_id: category.id, video_id: video_three.id)
      video_category_four = VideoCategory.create(category_id: category.id, video_id: video_four.id)
      video_category_five = VideoCategory.create(category_id: category.id, video_id: video_five.id)
      video_category_six = VideoCategory.create(category_id: category.id, video_id: video_six.id)
      video_category_seven = VideoCategory.create(category_id: category.id, video_id: video_seven.id)

      expect(category.most_recent).to eq([video_seven, video_five, video_three, video_one, video_six, video_four])
    end
  end
end
