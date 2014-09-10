
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
    @user = User.new(email_address: @invitation.invitee_email_address)
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      flash[:success] = "You are now registered as #{@user.full_name}. Welcome to MyFlix!"
      redirect_to signin_path
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
end
