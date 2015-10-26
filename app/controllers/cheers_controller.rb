class CheersController < ApplicationController

  def create
    @cheer = current_user.cheers.new
    @cheer.goal_id = params[:goal_id]

    if !@cheer.save
      flash[:errors] = @cheers.errors.full_messages
    end

    redirect_to goal_url(@cheer.goal)
  end


end
