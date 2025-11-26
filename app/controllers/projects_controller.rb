class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :edit, :update ]
  before_action :authorize_project!, only: [ :edit, :update ]

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to root_path, notice: "Project created successfully"
    else
      render :new
    end
  end

  def edit
    puts "========= IN PROJECTS CONTROLLER EDIT ========="
    puts "params[:id] = #{params[:id]}"
    puts "params[:project_id] = #{params[:project_id]}"
    puts "@project = #{@project.inspect}"
  end 

  def update
    if @project.update(project_params)
      redirect_to root_path, notice: "Project updated successfully"
    else
      render :edit
    end
  end
end

private

def project_params
  params.require(:project).permit(:title, :client, :project_type, :start_date, :estimated_end_date)
end

def set_project
  @project = Project.find(params[:id])
end

def authorize_project!
  redirect_to root_path unless @project.user == current_user
end
