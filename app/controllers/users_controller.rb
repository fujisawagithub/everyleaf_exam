class UsersController < ApplicationController

  def new
    if logged_in?
      flash[:denger] = '権限がありません'
      redirect_to tasks_path
    else
    @user = User.new
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(current_user.id)
    @tasks = current_user.tasks
    @tasks = @tasks.page(params[:page]).per(10)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
