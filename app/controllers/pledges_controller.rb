class PledgesController < ApplicationController
  # before_action :not_authenticated

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user
    # @pledge.reward_id = nil

    if @pledge.dollar_amount >= 50 #@project.dollar_amountd
      @pledge.reward_id = Reward.find_by :pledge_id(params[reward_id])
    end

    if @pledge.save
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
    else
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end

  def show

  end

  # <!-- <% if @project.reward_id  %>
  # <p>You have been rewarded with <%= @project.reward.description %></p>
  # <% end  %> -->
end
