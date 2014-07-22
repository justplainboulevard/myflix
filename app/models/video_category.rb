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

class VideoCategory < ActiveRecord::Base

  belongs_to :video
  belongs_to :category
end
