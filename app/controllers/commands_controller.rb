class CommandsController < ApplicationController
  before_filter :require_authenticated, :except => [:index, :show]
  
  def index
    @commands = Command.all(:order => :name)
  end
  
  def new
    @command = Command.new
  end
  
  def create
    @command = Command.new(params[:command])
    @command.creator_id = current_user.member_id
    if @command.save
      redirect_to @command
    else
      render :action => "new"
    end
  end
  
  def show
    @command = Command.find_by_id(params[:id])
  end
  
  def edit
    @command = Command.find_by_id(params[:id])
  end
  
  def update
    if @command = Command.find_by_id(params[:id])
      @command.updater_id = current_user.member_id
      if @command.update_attributes(params[:command])
        redirect_to @command
      else
        render :action => "edit"
      end
    else
      redirect_to commands_path
    end
  end
  
  def destroy
    if @command = Command.find_by_id(params[:id])
      @command.destroy
      flash[:notice] = "Command deleted."
      redirect_to commands_path
    else
      redirect_to commands_path
    end
  end
end
