class TasksController < ApplicationController
  before_action :set_user
  before_action :correct_user, only: [:index, :show, :edit, :update]
  
  def show
    @task = @user.tasks
  end
  
  def new
    @task = Task.new
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
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_tasks_url @user
    else
      render :edit
    end
  end
  
  def index
    @tasks = @user.tasks
  end
  
  private
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
