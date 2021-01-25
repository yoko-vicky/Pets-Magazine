class ApplicationController < ActionController::Base
  helper_method :current_user, :login?, :already_voted?, :categories

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login?
    current_user ? true : false
  end

  def require_login
    return if login? && current_user

    flash[:alert] = 'This action requires you to login'
    redirect_to login_path
  end

  def require_same_user(user)
    return if current_user == user

    flash[:alert] = 'This action can be done only by the authorized user'
    redirect_to root_path
  end

  def categories
    @categories ||= Category.prioritize
  end
end
