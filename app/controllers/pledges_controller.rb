class PledgesController < ApplicationController
  # before_action :not_authenticated

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user

    if @pledge.save
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
    else
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end

  def self.sum_of_all_pledges_for_all_projects
    total = Pledge.all.sum(:dollar_amount) 
    return  total
  end 

end
