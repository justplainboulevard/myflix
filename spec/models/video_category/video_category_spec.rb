# == Schema Information
#
# Table name: video_categories
#
#  id          :integer          not null, primary key
#  video_id    :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe VideoCategory, type: :model do

  it { should belong_to(:video) }
  it { should belong_to(:category) }
end
