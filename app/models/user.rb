
class User < ActiveRecord::Base

  validates_presence_of :email_address, :password, :full_name
end
