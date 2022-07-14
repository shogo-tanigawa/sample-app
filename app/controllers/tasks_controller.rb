class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(description: params[:description])
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index
     @tasks = Task.all
     @user = User.find(params[:user_id])
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks
  end
end
