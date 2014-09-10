# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  leader_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#


class Relationship < ActiveRecord::Base

  belongs_to :leader, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
