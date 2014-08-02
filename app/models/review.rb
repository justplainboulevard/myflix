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

class Review < ActiveRecord::Base

  belongs_to :author, foreign_key: 'user_id', class_name: 'User'
  belongs_to :video

  validates :body, presence: true, length: { maximum: 1500 }
  validates :rating, presence: true
end
