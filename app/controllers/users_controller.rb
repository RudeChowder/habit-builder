class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    authorize
    @habits = @user.habits.uniq
  end

private

  def authorize
    if !@user
      flash[:warning] = "Could not find that user"
      redirect_to :root
    elsif @user != current_user
      flash[:warning] = "You do not have permission to view that profile"
      redirect_to :root, code: :forbidden
    end
  end
end
