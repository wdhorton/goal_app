class GoalCommentsController < ApplicationController

  def create
    @goal_comment = GoalComment.new(goal_comment_params)
    @goal_comment.author = current_user
    @goal_comment.goal_id = params[:goal_id]

    if !@goal_comment.save
      flash[:errors] = @goal_comment.errors.full_messages
    end

    redirect_to goal_url(@goal_comment.goal_id)
  end

  private

  def goal_comment_params
    params.require(:goal_comment).permit(:body)
  end

end
