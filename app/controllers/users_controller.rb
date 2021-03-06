class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def new
    if logged_in?
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
    @user = User.find(params[:id])
    if @user.id != current_user.id 
      redirect_to tasks_path,notice:"権限がありません"
    end
    @tasks = @user.tasks.all
    @tasks = @tasks.page(params[:page]).per(10)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
