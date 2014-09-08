
class Invitation < ActiveRecord::Base

  belongs_to :inviter, foreign_key: :user_id, class_name: 'User'
end
