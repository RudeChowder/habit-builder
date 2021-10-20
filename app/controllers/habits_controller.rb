class HabitsController < ApplicationController
  before_action :authenticate_user!

  def show
    set_user
    @habit = Habit.find_by(id: params[:id])
    @checkin_count = @user.checkin_count_for_habit(@habit)
    @oldest_checkin_date = @habit.oldest_checkin_for_user(@user).pretty_date
  end
end
