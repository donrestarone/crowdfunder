class ReviewsController < ApplicationController
  def create
    @review = Review.new

    @review.content = params[:review][:content]
    @review.project_id = params[:project_id]
    #
    @review.user_id = current_user.id

    if @review.save!
      redirect_to project_path(id: params[:project_id])
    else
      flash[:warning] = @review.errors.full_messages
      redirect_to project_path(id: params[:project_id])
    end
  end

  #----------------------------------------------------

  def index
  end

  def show
  end
  #----------------------------------------------------

  def edit
    review_id = params[:id]
    @review = Review.find(review_id)
    @project = @review.project
  end

  def update
    review_id = params[:id]
    @review = Review.find(review_id)

    project_id = params[:project_id]
    @project = Project.find(project_id)

    @review.content = params[:review][:content]

    if @review.save
      redirect_to project_path(id: project_id)
    else
      render :edit
    end
  end

  #----------------------------------------------------

  def destroy
    review_id = params[:id]
    project_id = params[:project_id]
    @review = Review.find(review_id)
    @review.destroy
    redirect_to project_path(id: project_id)
  end
end
