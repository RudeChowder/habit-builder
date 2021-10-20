class CheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checkin, only: %i[show edit update destroy]
  before_action :set_user_and_authorize

  def index
    @checkins = @user&.checkins
  end

  def show; end

  def new
    @checkin = Checkin.new(date: Date.today)
    prep_form
  end

  def create
    @checkin = Checkin.new(checkin_params)
    if @checkin.save
      flash[:success] = "Check in created!"
      redirect_to @checkin.user
    else
      prep_form
      render :new
    end
  end

  def destroy
    @checkin&.destroy
    flash[:success] = "Checkin successfully deleted"
    redirect_to current_user
  end

  def edit
    prep_form
  end

  def update
    @checkin.assign_attributes(checkin_params)
    if @checkin.save
      flash[:success] = "Checkin updated!"
      redirect_to @checkin.user
    else
      prep_form
      render :new
    end
  end

private

  def checkin_params
    params.require(:checkin).permit(:user_id, :date, :notes, habit_ids: [], habits_attributes: [:name])
  end

  def prep_form
    @habit = @checkin.habits.build
    @habits = Habit.all
  end

  def set_checkin
    @checkin = Checkin.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, we could not find that checkin"
    redirect_to user_checkins_path(current_user)
  end
end
