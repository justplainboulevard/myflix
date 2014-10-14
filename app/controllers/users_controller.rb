
class UsersController < ApplicationController

  before_action :require_user, only: [:show, :people]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def new_with_invitation_token
    @invitation = Invitation.where(token: params[:token]).first

    if @invitation
      @user = User.new(email_address: @invitation.invitee_email_address)
      @invitation_token = @invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      charge = charge_card
      if charge.successful?
        @user.save
        handle_invitation
        UserMailer.delay.welcome_email(@user)
        session[:user_id] = @user.id
        flash[:success] = "You are now registered as #{@user.full_name}. Welcome to MyFlix!"
        redirect_to signin_path
      else
        flash[:error] = charge.error_message # 'Your card was declined.'
        render :new
      end
    else
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit(:email_address, :password, :full_name)
  end

  def set_user
    @user = current_user
  end

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

  def charge_card
    StripeWrapper::Charge.create(
        amount: 999,
        card: params[:stripeToken],
        description: "MyFlix subscription charge for #{@user.email_address}"
      )
  end
end
