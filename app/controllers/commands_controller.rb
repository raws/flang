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
    @command.user_id = current_user.member_id
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
  end

  def destroy
  end
end
