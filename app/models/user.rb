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
  has_many :reviews

  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address

  def normalize_list_order
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_order: index + 1)
    end
  end
end
