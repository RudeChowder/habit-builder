class CheckinsController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end
  
  def show

  end
  
  def new
    @checkin = Checkin.new(date: Date.today)
    prep_form
  end

  def create
    @checkin = Checkin.new(checkin_params)
    if @checkin.save
      flash[:success] = "Check in created! Thanks for taking care of yourself!"
      redirect_to @checkin.user
    else
      prep_form
      render :new
    end
  end

  def destroy
    @checkin = Checkin.find_by(params[:id])
    @checkin&.destroy
    flash[:success] = "Checkin successfully deleted"
    redirect_to current_user
  end

private

  def checkin_params
    params.require(:checkin).permit(:user_id, :date, :notes, habit_ids: [], habits_attributes: [:name])
  end

  def prep_form
    @user = User.find_by(id: params[:user_id])
    @habit = @checkin.habits.build
    @habits = Habit.all
  end
end
