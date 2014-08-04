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

    let(:videos) { Fabricate.times(5, :video) }

    it 'returns an empty array if no match' do
      expect(Video.search_by_title('Return an Empty Array')).to eq([])
    end

    it 'returns an array with one video if an exact match' do
      exact_match = Fabricate(:video, title: 'Exact Match')

      expect(Video.search_by_title('Exact Match')).to eq([exact_match])
    end

    it 'returns an array with one video if a partial match' do
      partial_match = Fabricate(:video, title: 'Partial Match')

      expect(Video.search_by_title('Partial')).to eq([partial_match])
    end

    it 'returns an array of all matches ordered by created_at' do
      match_one = Fabricate(:video, title: 'A Match', created_at: 1.day.ago)
      match_two = Fabricate(:video, title: 'Another Match')

      expect(Video.search_by_title('Match')).to eq([match_two, match_one])
    end

    it 'returns an empty array if the query is an empty string' do
      expect(Video.search_by_title('')).to eq([])
    end
  end
end
