class GoalsController < ApplicationController

  before_action :ensure_goal_owned_by_user, only: [:edit, :update, :destroy]
  before_action :ensure_logged_in, only: [:new, :create]
  before_action :cant_view_private_goal, only: [:show]

  def cant_view_private_goal
    @goal = Goal.find(params[:id])

    unless @goal.user == current_user || !@goal.private
      flash[:errors] = ["Can't view another user's private goal"]
      redirect_to goals_url
    end
  end

  def ensure_goal_owned_by_user
    @goal = Goal.find(params[:id])

    unless @goal.user == current_user
      flash[:errors] = ["Can't modify another user's goals"]
      redirect_to goal_url(@goal)
    end
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def index
    @goals = Goal.where("private = ? OR user_id = ?", false, current_user.id)
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find(params[:id])

    @goal.destroy
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :private, :completed)
  end

end
