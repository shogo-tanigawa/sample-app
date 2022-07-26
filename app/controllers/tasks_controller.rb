class TasksController < ApplicationController
  before_action :set_user
  before_action :logged_in_user, only: [:new, :index, :show, :edit, :update, :destroy]
  
  def show
    @tasks = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
    unless @user.id == current_user.id
      redirect_to root_url
    end
  end
  
  def create
    @task = @user.tasks.create(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
    unless @user.id == current_user.id
        flash[:danger]="ログインユーザー以外のタスク編集はできません。"
        redirect_to user_tasks_url current_user
    end
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url @user
    else
      render :edit
    end
  end
  
  def index
    @tasks = @user.tasks
  end
  
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:success] = "タスクを削除しました。"
      redirect_to user_tasks_url @user
    end
  end
  private
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
