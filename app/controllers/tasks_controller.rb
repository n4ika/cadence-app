class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_project, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_task, only: [ :edit, :update, :destroy ]

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: "Task created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: "Task updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "Task deleted successfully"
  end
end

private

def task_params
  params.require(:task).permit(:title, :description, :due_date, :status)
end

def set_task_project
  @project = current_user.projects.find(params[:project_id])
end

def set_task
  @task = current_user.tasks.find(params[:id])
end