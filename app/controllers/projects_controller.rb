class ProjectsController < ApplicationController
  before_action :not_authenticated, only: [:new, :create, :myprojects]

  def index
   @search_query = ""
   @projects = Project.all
      if params[:search] && params[:search][:title] != ""
        @search_query = params[:search][:title]
        @projects = Project.where('title ILIKE ?', "%#{@search_query}%")
      end

      # User.where('name ilike any ( array[?] )',['%thomas%','%james%','%martin%'])

    @projects = @projects.order(:end_date)

    #variables for homepage
    @total_num_projects = Project.number_of_all_projects
    @sum_of_all_pledges_all_projects = Pledge.sum_of_all_pledges_for_all_projects
    @funded_projects = Project.how_many_projects_funded.count
    @projects_waiting_funding = Project.projects_waiting_to_be_funded
  end

  def show
    @project = Project.find(params[:id])
    @project_owner = owner_of_project(@project)
    @funding_thus_far = @project.project_funding(@project.id)
    @users = @project.users

    if current_user
      @pledge_amount = current_user.amount_pledged_to_project(@project)
    end
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
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_url
    else
      render :new
    end
  end


   def myprojects
     @projects = current_user.projects
     @num_projects_backed_by_self = current_user.projects_backed.count

     @backed_projects_by_self = current_user.name_of_projects_backed
    end

end
