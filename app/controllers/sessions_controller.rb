
class SessionsController < ApplicationController

  def new
    redirect_to home_path if signed_in?
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user && user.authenticate(params[:password])
      if user.active?
        signin_user!(user)
      else
        flash.now[:danger] = 'Your account has been suspended. Please contact customer service.'
        render :new
      end
    else
      flash.now[:danger] = 'The username or password that you provided is incorrect.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You are now signed out.'
    redirect_to root_path
  end

private

  def signin_user!(user)
    session[:user_id] = user.id
    flash[:success] = "You are now signed in as #{user.full_name}."
    redirect_to home_path
  end
end
