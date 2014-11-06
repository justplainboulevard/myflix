# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  amount       :integer
#  reference_id :string(255)
#

class Payment < ActiveRecord::Base

  belongs_to :user
end
