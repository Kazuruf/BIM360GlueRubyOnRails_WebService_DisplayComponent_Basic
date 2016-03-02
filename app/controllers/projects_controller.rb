class ProjectsController < ApplicationController
  def index
    auth_token = session[:auth_token]
    response = glue_get_projects(auth_token)
    if response.code == '200'
      result = JSON.parse(response.body)
      @projects = result["project_list"]
      if @projects.nil?
        puts "error"
        redirect_to login_path
      end
    else
      redirect_to login_path
    end
  end
  def show
    auth_token = session[:auth_token]
    response = glue_get_project_by_id(auth_token, params[:id])
    if response.code == '200'
      result = JSON.parse(response.body)
      @project = result
      if @project.nil?
        puts "error"
        redirect_to login_path
      end
    else
      redirect_to login_path
    end
  end
end
