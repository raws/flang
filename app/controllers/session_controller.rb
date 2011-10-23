class SessionController < ApplicationController
  before_filter :require_unauthenticated, :only => [:new, :create]
  
  def new
  end

  def create
    if member_id = User.authenticate(params[:username], params[:password])
      session[:user] = member_id
      if session[:history] && session[:history].length >= 3
        redirect_to session[:history][2]
      else
        redirect_to root_path
      end
    else
      flash[:alert] = "Invalid credentials."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user] = nil
    cookies.delete(:exp_sessionid)
    redirect_to root_path
  end
end
