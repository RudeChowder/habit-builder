class HabitsController < ApplicationController
  before_action :authenticate_user!

  def show
    @habit = Habit.find_by(id: params[:id])
  end
end
