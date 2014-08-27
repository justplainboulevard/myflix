
class PasswordResetController < ApplicationController

  def new
  end

  def create
    @user = User.where(email_address: params[:email_address]).first

    if @user
      AppMailer.reset_password_email(@user).deliver
      redirect_to password_reset_confirmation_path
    else
      flash[:danger] = params[:email_address].blank? ? 'Email address cannot be blank.' : 'You submitted an invalid email address.'
      redirect_to forgot_password_path
    end
  end

  def confirm
  end

  def show
    @user = User.where(token: params[:id]).first

    if @user
      @token = @user.token
    else
      redirect_to expired_token_path
    end
  end

  def expired_token
  end

  def reset_password
    @user = User.where(token: params[:token]).first

    if @user
      @user.password = params[:password]
      @user.generate_token
      @user.save
      flash[:success] = 'You successfully reset your password. Please sign in using your new password.'
      redirect_to signin_path
    else
      redirect_to expired_token_path
    end
  end
end
