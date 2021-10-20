class ApplicationController < ActionController::Base
  def authorize
    if @user != current_user
      flash[:warning] = "You do not have permission to view that profile"
      redirect_to :root, code: :forbidden
    end
  end

  def set_user
    @user = User.find_by!(id: params[:user_id])
  rescue ActiveRecord::RecordNotFound
    user_not_found
  end

  def set_user_and_authorize
    set_user
    authorize
  end

  def user_not_found
    flash[:warning] = "Sorry, I couldn't find that user"
    redirect_to :root
  end
end
