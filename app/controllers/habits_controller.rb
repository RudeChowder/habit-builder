class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_authorize, only: %i[show]
  before_action :set_habit, only: %i[show]

  def show
    if @habit.users.include?(@user)
      @checkin_count = @user.checkin_count_for_habit(@habit)
      @oldest_checkin_date = @habit.oldest_checkin_for_user(@user).pretty_date
    else
      flash[:warning] = "Looks like you haven't checked in for that habit before"
      redirect_to user_path(@user)
    end
  end

private

  def set_habit
    @habit = Habit.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, I could not find that habit"
    redirect_to current_user
  end
end
