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

  has_many :video_categories
  has_many :categories, -> { order('name') }, through: :video_categories

  validates_presence_of :title, :description
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 1500 }

  def self.search_by_title(query)
    return [] if query.blank?
    where("title LIKE ?", "%#{query}%").order('created_at DESC')
  end
end
