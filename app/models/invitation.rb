# == Schema Information
#
# Table name: invitations
#
#  id                    :integer          not null, primary key
#  inviter_id            :integer
#  invitee_name          :string(255)
#  invitee_email_address :string(255)
#  invitation_message    :text
#  created_at            :datetime
#  updated_at            :datetime
#  token                 :string(255)
#

class Invitation < ActiveRecord::Base

  belongs_to :inviter, foreign_key: :inviter_id, class_name: 'User'

  validates :invitee_name, presence: true
  validates :invitee_email_address, presence: true
  validates :invitation_message, presence: true

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
