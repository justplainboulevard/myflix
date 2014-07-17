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

class Video < ActiveRecord::Base

  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1500 }
end
