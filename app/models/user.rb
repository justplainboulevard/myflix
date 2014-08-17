# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string(255)
#  password_digest :string(255)
#  full_name       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  has_secure_password validations: false

  has_many :queue_items, -> { order('list_order') }
  has_many :reviews, -> { order('created_at DESC') }
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :follower_id

  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address

  def normalize_list_order
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_order: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def average_rating
    total = 0.0
    self.reviews.each do |review|
      total += review[:rating]
    end
    (total / reviews.count).round(1)
  end
end
