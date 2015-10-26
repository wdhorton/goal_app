class UserCommentsController < ApplicationController

  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.author = current_user
    @user_comment.user_id = params[:user_id]

    if !@user_comment.save
      flash[:errors] = @user_comment.errors.full_messages
    end

    redirect_to user_url(@user_comment.user_id)
  end


  private

  def user_comment_params
    params.require(:user_comment).permit(:body)
  end

end
