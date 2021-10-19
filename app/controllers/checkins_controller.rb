class CheckinsController < ApplicationController
  before_action :authenticate_user!
  
  def index

  end
  
  def show

  end
  
  def new
    @user = User.find_by(params[:user_id])
    @checkin = Checkin.new(date: Date.today)
    @habit = Habit.new
    @habits = Habit.all
  end

  def create

  end
end
