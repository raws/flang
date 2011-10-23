class SessionController < ApplicationController
  before_filter :require_unauthenticated, :only => [:new, :create]
  
  def new
  end

  def create
    if member_id = User.authenticate(params[:username], params[:password])
      session[:user] = member_id
      redirect_to root_path
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
