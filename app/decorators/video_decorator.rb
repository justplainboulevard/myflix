
class VideoDecorator < ApplicationDecorator

  include Draper::LazyHelpers

  delegate_all

  decorates_finders

  def display_average_rating
    content_tag(:span, "Rating: #{self.average_rating}/5.0")
  end

  def average_rating
    if object.reviews.count >= 1
      total = 0.0
      object.reviews.each do |review|
        total += ( review[:rating] || 0.0 )
      end
      (total / object.reviews.count).round(1)
    else
      0.0
    end
  end
end
