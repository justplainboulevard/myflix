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

  validates_numericality_of :list_order, { only_integer: true }

  def rating
    set_review
    @review.rating if @review
  end

  def rating=(new_rating)
    set_review
    if @review
      @review.update_column(:rating, new_rating)
    else
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  # def category_names
  #   category_names = []
  #   video.categories.each do |category|
  #     category_names << category.name
  #   end
  #   category_names
  # end

private

  def set_review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end
