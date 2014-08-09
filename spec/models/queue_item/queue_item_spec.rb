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
  it { should validate_numericality_of(:list_order).only_integer }
end
