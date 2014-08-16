
class UsersController < ApplicationController

  before_action :require_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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
