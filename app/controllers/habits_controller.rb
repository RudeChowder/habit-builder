class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_authorize, only: %i[show]
  before_action :set_habit, only: %i[show]

  def show
    @habit = Habit.find_by!(id: params[:id])
    @checkin_count = @user.checkin_count_for_habit(@habit)
    @oldest_checkin_date = @habit.oldest_checkin_for_user(@user).pretty_date
  end

private

  def set_habit
    @habit = Habit.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, I could not find that habit"
    redirect_to current_user
  end
end
