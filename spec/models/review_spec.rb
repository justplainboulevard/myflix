# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  rating     :integer
#  user_id    :integer
#  video_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Review, type: :model do

  it { should belong_to(:author).with_foreign_key('user_id').class_name('User') }
  it { should belong_to(:video) }

  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:body).is_at_most(1_500) }
  it { should validate_presence_of(:rating) }
end
