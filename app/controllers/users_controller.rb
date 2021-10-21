class UsersController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def show
    @user = User.find_by!(id: params[:id])
    authorize
    @habits = @user.current_habits
    @achieved_goals = @user.goals.achieved
    @unachieved_goals = @user.goals.unachieved
    @checkins = @user.last_three_checkins
  end
end
