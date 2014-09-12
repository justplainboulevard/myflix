
class InvitationsController < ApplicationController

  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      AppMailer.delay.invitation_email(@invitation)
      flash[:success] = "We sent your invitation to #{@invitation.invitee_name}!"
      redirect_to new_invitation_path
    else
      flash[:danger] = 'You submitted invalid data. Please check each form field.'
      render :new
    end
  end

private

  def invitation_params
    params.require(:invitation).permit(:invitee_name, :invitee_email_address, :invitation_message).merge!(inviter_id: current_user.id)
  end
end
