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

  has_secure_password

  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address
end
