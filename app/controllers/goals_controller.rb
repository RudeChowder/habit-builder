class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: %i[show edit update destroy]
  before_action :set_user_and_authorize

  def index
    @goals = @user&.goals
  end

  def show; end

  def new
    @goal = Goal.new()
    # prep_form
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = "New goal set!"
      redirect_to @goal.user
    else
      # prep_form
      render :new
    end
  end

  def destroy
    @goal&.destroy
    flash[:success] = "Goal successfully deleted"
    redirect_to current_user
  end

  def edit
    # prep_form
  end

  def update
    @goal.assign_attributes(goal_params)
    if @goal.save
      flash[:success] = "Goal updated!"
      redirect_to @goal.user
    else
      # prep_form
      render :new
    end
  end

private

  def goal_params
    params.require(:goal).permit(:user_id, :habit_id, :target)
  end

  def set_goal
    @goal = Goal.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, I could not find that goal"
    redirect_to user_goals_path(current_user)
  end
end
