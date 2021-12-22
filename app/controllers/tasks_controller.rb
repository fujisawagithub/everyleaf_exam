class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :prohibit_access

  def index
    @tasks = current_user.tasks.order(id: 'DESC')
    @tasks = current_user.tasks.order(deadline: 'DESC') if params[:sort_expired]
    @tasks = current_user.tasks.order(priority: 'ASC') if params[:sort_priority]
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = current_user.tasks.scope_title(params[:task][:title]).scope_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.scope_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.scope_status(params[:task][:status])
      elsif params[:task][:label_id].present?
        @tasks = @tasks.joins(:labels).where(labels: { id: params[:task][:label_id] })
      end
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'タスクを保存しました！' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクを更新しました！' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました！' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, { label_ids: [] })
  end

  def prohibit_access
    redirect_to new_session_path unless current_user
  end
end
