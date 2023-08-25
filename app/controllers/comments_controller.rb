class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    # biding.pry
    if @comment.save
      # redirect_to prototype_path(@comment.prototype)
      redirect_to prototype_path(@comment.prototype.id)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @comment = Comment.new
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    # params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end