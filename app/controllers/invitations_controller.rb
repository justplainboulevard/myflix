
class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    redirect_to invitation_confirmation_path
  end
end
