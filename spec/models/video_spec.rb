# == Schema Information
#
# Table name: videos
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  poster_small_url :string(255)
#  poster_large_url :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

# TO DO: add #average_rating test

require 'rails_helper'

RSpec.describe Video, type: :model do

  it { should have_many(:video_categories) }
  it { should have_many(:categories).through(:video_categories) }
  it { should have_many(:reviews).order('created_at DESC') }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:title).is_at_most(150) }
  it { should ensure_length_of(:description).is_at_most(1_500) }

  describe '.search_by_title' do
    it 'returns an empty array if no match' do
      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')

      expect(Video.search_by_title('Three')).to eq([])
    end

    it 'returns an array with one video if an exact match' do
      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')

      expect(Video.search_by_title('My Video One')).to eq([video_one])
    end

    it 'returns an array with one video if a partial match' do
      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')

      expect(Video.search_by_title('ne')).to eq([video_one])
    end

    it 'returns an array of all matches ordered by created_at' do
      video_one = Video.create(title: 'My Video One', description: 'My video one description.', created_at: 1.day.ago)
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')

      expect(Video.search_by_title('My Video')).to eq([video_two, video_one])
    end

    it 'returns an empty array if the query is an empty string' do
      video_one = Video.create(title: 'My Video One', description: 'My video one description.')
      video_two = Video.create(title: 'My Video Two', description: 'My video two description.')

      expect(Video.search_by_title('')).to eq([])
    end
  end
end
