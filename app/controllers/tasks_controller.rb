class TasksController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update]
  
  def show
    @task = @user.tasks
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new
    @task.name = params[:name]
    @task.description = params[:description]
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def index
    @tasks = Task.all
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
end
