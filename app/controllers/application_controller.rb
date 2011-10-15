class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :logged_out?
  before_filter :check_for_session_cookie, lambda { logged_out? }
  
  def current_user
    @current_user ||= User.find_by_member_id(session[:user]) if logged_in?
  end
  
  def logged_in?
    session[:user].present?
  end
  
  def logged_out?
    !logged_in?
  end
  
  private
    def check_for_session_cookie
      if session_id = cookies[:exp_sessionid]
        if ee_session = Session.find_by_session_id(session_id)
          session[:user] = ee_session.member_id
        end
      end
    end
end
