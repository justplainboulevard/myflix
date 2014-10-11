
class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?, :require_user, :require_admin, :access_denied

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def require_user
    access_denied unless signed_in?
  end

  def require_admin
    # access_denied unless current_user.admin? # Would like to do this, but the difference is 'home_path' versus 'root_path'.
    if !current_user.admin?
      flash[:danger] = 'Access denied! You cannot take that action.'
      redirect_to home_path
    end
  end

  def access_denied
    flash[:danger] = 'Access denied! You cannot take that action.'
    redirect_to root_path
  end
end
