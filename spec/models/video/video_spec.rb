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
  it { should have_many(:queue_items) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:title).is_at_most(150) }
  it { should ensure_length_of(:description).is_at_most(1_500) }
end
