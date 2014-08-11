
require 'rails_helper'

RSpec.describe Video, type: :model do

  describe '.search_by_title' do

    set_videos

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
