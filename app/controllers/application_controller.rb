class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :logged_out?
  
  def current_user
    @current_user ||= User.find_by_member_id(session[:user]) if logged_in?
  end
  
  def logged_in?
    session[:user].present?
  end
  
  def logged_out?
    !logged_in?
  end
end
