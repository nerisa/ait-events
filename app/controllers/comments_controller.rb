class CommentsController < ApplicationController

  before_action :get_new_idea

  load_and_authorize_resource

  def index
    @comments = @idea.comments
    @comment = @idea.comments.build
    @ideaList = NewIdea.all.where("restrict_display = false AND is_closed = false").order(created_at: :desc)
  end


  def create
    logger.info("Adding comment to #{@idea.id} with params #{params.inspect}")
    @comment = @idea.comments.build(resource_params)
    @comment.user = current_user
    if(!@comment.valid?)
      logger.debug("Could not save comment #{@comment.errors.inspect}")
      @errorMsg = "Your comment could not be saved. Please check your inputs."
      return
    end
    @comment.save
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(resource_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @id = @comment.id
    @comment.destroy
  end

  private

  def get_new_idea
    @idea = NewIdea.find(params[:new_idea_id])
  end

  def resource_params
    params.require(:comment).permit(:description)
  end
end
