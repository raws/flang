class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :logged_out?
  before_filter :add_to_session_history
  before_filter :check_for_session_cookie
  
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
    def add_to_session_history
      session[:history] ||= []
      session[:history].unshift(request.path)
      session[:history].pop if session[:history].size > 3
    end
    
    def check_for_session_cookie
      return if logged_in?
      if session_id = cookies[:exp_sessionid]
        if ee_session = Session.find_by_session_id(session_id)
          session[:user] = ee_session.member_id
        end
      end
    end
    
    def require_authenticated
      unless logged_in?
        flash[:alert] = "Please sign in to do that!"
        redirect_to sign_in_path
      end
    end
    
    def require_unauthenticated
      unless logged_out?
        flash[:alert] = "You are already signed in."
        redirect_to root_path
      end
    end
end
