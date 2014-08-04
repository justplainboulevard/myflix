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

class QueueItem < ActiveRecord::Base

  belongs_to :video
  belongs_to :user

  def video_title
    video.title
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end
end
