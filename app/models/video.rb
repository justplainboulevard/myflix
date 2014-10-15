# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  small_cover :string(255)
#  large_cover :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Video < ActiveRecord::Base

  mount_uploader :small_cover, SmallCoverUploader
  mount_uploader :large_cover, LargeCoverUploader

  has_many :video_categories
  has_many :categories, -> { order('name') }, through: :video_categories
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items

  accepts_nested_attributes_for :video_categories

  validates_presence_of :title, :description
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 1500 }

  def self.search_by_title(query)
    return [] if query.blank?
    where("title LIKE ?", "%#{query}%").order('created_at DESC')
  end
end
