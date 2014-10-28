
class VideoDecorator < ApplicationDecorator

  delegate_all

  def average_rating
    if self.reviews.count >= 1
      total = 0.0
      self.reviews.each do |review|
        total += ( review[:rating] || 0.0 )
      end
      (total / self.reviews.count).round(1)
    else
      0.0
    end
  end
end
