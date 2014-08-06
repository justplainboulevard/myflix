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

      videos = Fabricate.times(4, :video)
      videos.each do |video|
        Fabricate(:video_category, category_id: category.id, video_id: video.id)
      end

      expect(category.most_recent.size).to eq(videos.size)
    end

    it 'returns an array of only six videos if there are more than six videos in the category' do

      videos = Fabricate.times(7, :video)
      videos.each do |video|
        Fabricate(:video_category, category_id: category.id, video_id: video.id)
      end

      expect(category.most_recent.size).to eq(6)
    end

    it 'returns an array ordered by created_at in reverse chronological order if two or more videos in the category' do

      old_video = Fabricate(:video, created_at: 1.day.ago)
      new_video = Fabricate(:video)
      videos = [old_video, new_video]
      videos.each do |video|
        Fabricate(:video_category, category_id: category.id, video_id: video.id)
      end

      expect(category.most_recent).to eq([new_video, old_video])
    end
  end
end
