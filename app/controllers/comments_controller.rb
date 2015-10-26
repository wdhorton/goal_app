class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to "/#{comment_params[:commentable_type].tableize}/#{comment_params[:commentable_id]}"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
