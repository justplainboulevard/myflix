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
end
