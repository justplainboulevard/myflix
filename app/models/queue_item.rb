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

  delegate :categories, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  # def category_names
  #   category_names = []
  #   video.categories.each do |category|
  #     category_names << category.name
  #   end
  #   category_names
  # end
end
