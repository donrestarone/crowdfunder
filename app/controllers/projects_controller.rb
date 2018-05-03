class ProjectsController < ApplicationController
  before_action :not_authenticated, only: [:new, :create, :myprojects]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)

    #variables for homepage
    @total_num_projects = Project.number_of_all_projects
    @sum_of_all_pledges_all_projects = Pledge.sum_of_all_pledges_for_all_projects
    @funded_projects = Project.how_many_projects_funded.count
    @projects_waiting_funding = Project.projects_waiting_to_be_funded
  end

  def show
    @project = Project.find(params[:id])
    @funding_thus_far = @project.project_funding(params[:id])

  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]

    if @project.save
      redirect_to projects_url
    else
      render :new
    end
   end

   def myprojects
     @projects = current_user.projects
   end

end
